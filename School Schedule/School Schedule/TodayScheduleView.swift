import SwiftUI

struct TodayScheduleView: View {
    @AppStorage("classes") private var classesData: Data = Data()
    @AppStorage("lunch") private var lunch: String = "A"   // "A" or "B"
    
    @State private var classes: [ClassInfo] = []
    @State private var now = Date()
    @State private var showEdit = false
    
    private let tick = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        List {
            ForEach(todayBlocks()) { block in
                let status = blockStatus(block, now: now)
                let isPassing = block.name.lowercased().contains("passing")
                
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: isPassing ? 2 : 4) {
                        Text(primaryTitle(for: block))
                            .font(isPassing ? .subheadline : .headline)
                        Text("\(block.start) — \(block.end)")
                            .font(isPassing ? .caption2 : .caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    switch status {
                    case .finished:
                        Image(systemName: "checkmark.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(.green)
                    case .inProgress(let remaining):
                        Text(remaining)
                            .font(.caption)
                            .monospacedDigit()
                            .foregroundColor(.blue)
                    case .upcoming:
                        Image(systemName: "xmark.circle")
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.vertical, isPassing ? 4 : 8) // smaller for passing
                .listRowBackground(backgroundColor(for: status))
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Today's Schedule")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") { showEdit = true }
            }
        }
        .sheet(isPresented: $showEdit) {
            ContentView()
        }
        .onAppear {
            loadClasses()
        }
        .onReceive(tick) { t in
            now = t
        }
        // ADD THIS: Watch for changes to classesData and reload when it changes
        .onChange(of: classesData) { _, _ in
            loadClasses()
        }
        // ADD THIS: Watch for changes to lunch selection and reload
        .onChange(of: lunch) { _, _ in
            loadClasses()
        }
    }
}

// MARK: - Titles

private extension TodayScheduleView {
    func primaryTitle(for block: ScheduleBlock) -> String {
        // If it's a "Period N", show the user's class + room; else show the block name (Passing/Lunch/LEAP/etc.)
        if block.name.hasPrefix("Period"),
           let num = Int(block.name.components(separatedBy: " ").last ?? ""),
           let info = classes[safe: num - 1],
           !info.name.trimmingCharacters(in: .whitespaces).isEmpty {
            if info.room.trimmingCharacters(in: .whitespaces).isEmpty {
                return "\(block.name): \(info.name)"
            } else {
                return "\(block.name): \(info.name) (\(info.room))"
            }
        }
        return block.name
    }
}

// MARK: - Data helpers

private extension TodayScheduleView {
    func loadClasses() {
        if let decoded = try? JSONDecoder().decode([ClassInfo].self, from: classesData) {
            classes = decoded
        }
    }
    
    func todayBlocks() -> [ScheduleBlock] {
        let df = DateFormatter()
        df.dateFormat = "EEEE"
        let day = df.string(from: now) // e.g. "Monday"
        let source = (lunch == "A") ? schedules : schedulesBLunch
        return source[day] ?? []
    }
}

// MARK: - Time / status

private extension TodayScheduleView {
    enum BlockState {
        case finished
        case inProgress(remaining: String)
        case upcoming
    }
    
    func blockStatus(_ block: ScheduleBlock, now: Date) -> BlockState {
        guard
            let start = timeToday(from: block.start, now: now),
            let end   = timeToday(from: block.end,   now: now)
        else { return .upcoming }
        
        if now >= end {
            return .finished
        } else if now >= start && now < end {
            let remaining = Int(end.timeIntervalSince(now))
            return .inProgress(remaining: fmt(remaining))
        } else {
            return .upcoming
        }
    }
    
    // Parse "h:mm a" and attach today's date.
    func timeToday(from timeString: String, now: Date) -> Date? {
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "yyyy-MM-dd"
        let dayString = dayFormatter.string(from: now)
        
        let fullFormatter = DateFormatter()
        fullFormatter.locale = Locale(identifier: "en_US_POSIX")
        fullFormatter.dateFormat = "yyyy-MM-dd h:mm a"
        return fullFormatter.date(from: "\(dayString) \(timeString)")
    }
    
    func fmt(_ seconds: Int) -> String {
        let m = seconds / 60
        let s = seconds % 60
        return "\(m):" + String(format: "%02d", s)
    }
    
    func backgroundColor(for state: BlockState) -> Color {
        switch state {
        case .finished:   return Color.green.opacity(0.10)
        case .inProgress: return Color.yellow.opacity(0.18)
        case .upcoming:   return Color.clear
        }
    }
}

// MARK: - Safe index

private extension Array {
    subscript(safe i: Int) -> Element? {
        indices.contains(i) ? self[i] : nil
    }
}
