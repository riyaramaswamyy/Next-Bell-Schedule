import SwiftUI
import ActivityKit

@main
struct School_ScheduleApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @AppStorage("classes") private var classesData: Data = Data()
    @AppStorage("lunch") private var lunch: String = "A"
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                TodayScheduleView()
            }
        }
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .background {
                startLiveActivityWithTimerHack()
            }
        }
    }
    
    // 🔥 THE MAGIC: Only ONE update needed for entire school day!
    private func startLiveActivityWithTimerHack() {
        // End any existing activities first
        for activity in Activity<ScheduleAttributes>.activities {
            Task {
                await activity.end(nil, dismissalPolicy: .immediate)
            }
        }
        
        guard ActivityAuthorizationInfo().areActivitiesEnabled else {
            print("Live Activities not enabled")
            return
        }
        
        let scheduleInfo = getCurrentScheduleInfo()
        
        // Skip if no school today
        if scheduleInfo.currentBlock == "No School" || scheduleInfo.blockEndTime == nil {
            print("📅 No school today - skipping Live Activity")
            return
        }
        
        do {
            let attributes = ScheduleAttributes(name: "Schedule")
            let contentState = ScheduleAttributes.ContentState(
                currentBlock: scheduleInfo.currentBlock,
                currentRoom: scheduleInfo.currentRoom,
                blockEndTime: scheduleInfo.blockEndTime!, // 🎯 The magic date!
                nextBlock: scheduleInfo.nextBlock,
                nextRoom: scheduleInfo.nextRoom,
                nextBlockStartTime: scheduleInfo.nextBlockStartTime,
                isBreak: scheduleInfo.isBreak
            )
            
            // ✅ NO PUSH NEEDED - Timer handles everything!
            let activity = try Activity<ScheduleAttributes>.request(
                attributes: attributes,
                content: ActivityContent(
                    state: contentState,
                    staleDate: Calendar.current.date(byAdding: .hour, value: 8, to: Date())
                ),
                pushType: nil
            )
            
            print("🎯 Started Live Activity with LIVE TIMER: \(scheduleInfo.currentBlock)")
            print("🔥 Will auto-update every SECOND until \(scheduleInfo.blockEndTime!)")
            
            // 📋 Schedule ONE update when current period ends (for next period)
            Task {
                await scheduleNextPeriodUpdate(activity: activity, endTime: scheduleInfo.blockEndTime!)
            }
            
        } catch {
            print("❌ Error starting Live Activity: \(error)")
        }
    }
    
    // 📅 Schedule update when current period ends (to show next period)
    private func scheduleNextPeriodUpdate(activity: Activity<ScheduleAttributes>, endTime: Date) async {
        // Calculate how long until this period ends
        let timeUntilEnd = endTime.timeIntervalSinceNow
        
        if timeUntilEnd > 0 {
            // Wait until period ends, then update to next period
            try? await Task.sleep(nanoseconds: UInt64(timeUntilEnd * 1_000_000_000))
            
            // Update to next period
            let newScheduleInfo = getCurrentScheduleInfo()
            
            if newScheduleInfo.currentBlock == "School Ended" || newScheduleInfo.blockEndTime == nil {
                // School ended
                await activity.end(nil, dismissalPolicy: .immediate)
                print("🏫 School ended - Live Activity completed")
                return
            }
            
            // Update to next period with new timer
            let newContentState = ScheduleAttributes.ContentState(
                currentBlock: newScheduleInfo.currentBlock,
                currentRoom: newScheduleInfo.currentRoom,
                blockEndTime: newScheduleInfo.blockEndTime!,
                nextBlock: newScheduleInfo.nextBlock,
                nextRoom: newScheduleInfo.nextRoom,
                nextBlockStartTime: newScheduleInfo.nextBlockStartTime,
                isBreak: newScheduleInfo.isBreak
            )
            
            let newContent = ActivityContent(
                state: newContentState,
                staleDate: Calendar.current.date(byAdding: .hour, value: 2, to: Date())
            )
            
            do {
                await activity.update(newContent, alertConfiguration: nil)
                print("🔄 Updated to next period: \(newScheduleInfo.currentBlock)")
                
                // Schedule next update
                if let nextEndTime = newScheduleInfo.blockEndTime {
                    await scheduleNextPeriodUpdate(activity: activity, endTime: nextEndTime)
                }
            }
        }
    }
    
    private func getCurrentScheduleInfo() -> (currentBlock: String, currentRoom: String, blockEndTime: Date?, nextBlock: String, nextRoom: String, nextBlockStartTime: Date?, isBreak: Bool) {
        let now = Date()
        let df = DateFormatter()
        df.dateFormat = "EEEE"
        let day = df.string(from: now)
        
        let source = (lunch == "A") ? schedules : schedulesBLunch
        let blocks = source[day] ?? []
        
        // Load classes
        var classes: [ClassInfo] = []
        if let decoded = try? JSONDecoder().decode([ClassInfo].self, from: classesData) {
            classes = decoded
        }
        
        var currentBlock = "No School"
        var currentRoom = ""
        var blockEndTime: Date? = nil
        var nextBlock = ""
        var nextRoom = ""
        var nextBlockStartTime: Date? = nil
        var isBreak = false
        
        for (index, block) in blocks.enumerated() {
            guard let start = timeToday(from: block.start, now: now),
                  let end = timeToday(from: block.end, now: now) else { continue }
            
            if now >= start && now < end {
                // Currently in this block
                currentBlock = getBlockDisplayName(block, classes: classes)
                currentRoom = getRoomForBlock(block, classes: classes)
                blockEndTime = end // 🎯 The magic - actual end time!
                isBreak = block.name.lowercased().contains("passing") ||
                         block.name.lowercased().contains("lunch") ||
                         block.name.lowercased().contains("break")
                
                // Find next non-passing block
                for nextIndex in (index + 1)..<blocks.count {
                    let nextBlockItem = blocks[nextIndex]
                    if !nextBlockItem.name.lowercased().contains("passing") {
                        nextBlock = getBlockDisplayName(nextBlockItem, classes: classes)
                        nextRoom = getRoomForBlock(nextBlockItem, classes: classes)
                        nextBlockStartTime = timeToday(from: nextBlockItem.start, now: now)
                        break
                    }
                }
                break
            } else if now < start {
                // This is upcoming - show time until next class
                if !block.name.lowercased().contains("passing") {
                    currentBlock = "Break"
                    blockEndTime = start // End of break = start of next class
                    isBreak = true
                    nextBlock = getBlockDisplayName(block, classes: classes)
                    nextRoom = getRoomForBlock(block, classes: classes)
                    nextBlockStartTime = start
                    break
                }
            }
        }
        
        // If no current block found, check if it's after school
        if currentBlock == "No School" && !blocks.isEmpty {
            if let lastBlock = blocks.last,
               let lastEnd = timeToday(from: lastBlock.end, now: now),
               now > lastEnd {
                currentBlock = "School Ended"
                blockEndTime = nil
            }
        }
        
        return (currentBlock, currentRoom, blockEndTime, nextBlock, nextRoom, nextBlockStartTime, isBreak)
    }
    
    private func getBlockDisplayName(_ block: ScheduleBlock, classes: [ClassInfo]) -> String {
        if block.name.hasPrefix("Period"),
           let num = Int(block.name.components(separatedBy: " ").last ?? ""),
           classes.indices.contains(num - 1) {
            let classInfo = classes[num - 1]
            if !classInfo.name.trimmingCharacters(in: .whitespaces).isEmpty {
                return classInfo.name
            }
        }
        return block.name
    }
    
    private func getRoomForBlock(_ block: ScheduleBlock, classes: [ClassInfo]) -> String {
        if block.name.hasPrefix("Period"),
           let num = Int(block.name.components(separatedBy: " ").last ?? ""),
           classes.indices.contains(num - 1) {
            let classInfo = classes[num - 1]
            return classInfo.room.trimmingCharacters(in: .whitespaces)
        }
        return ""
    }
    
    private func timeToday(from timeString: String, now: Date) -> Date? {
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "yyyy-MM-dd"
        let dayString = dayFormatter.string(from: now)
        
        let fullFormatter = DateFormatter()
        fullFormatter.locale = Locale(identifier: "en_US_POSIX")
        fullFormatter.dateFormat = "yyyy-MM-dd h:mm a"
        return fullFormatter.date(from: "\(dayString) \(timeString)")
    }
}
