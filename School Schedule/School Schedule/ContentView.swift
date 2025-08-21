import SwiftUI

struct ContentView: View {
    @AppStorage("classes") private var classesData: Data = Data()
    @AppStorage("lunch") private var lunch: String = "A"   // <- persisted A/B lunch choice
    
    @State private var classes: [ClassInfo] = Array(repeating: ClassInfo(name: "", room: ""), count: 6)
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Lunch")) {
                    Picker("Lunch", selection: $lunch) {
                        Text("1st Lunch").tag("A")
                        Text("2nd Lunch").tag("B")
                    }
                    .pickerStyle(.segmented)
                }
                
                ForEach(0..<6, id: \.self) { index in
                    Section(header: Text("Period \(index + 1)")) {
                        TextField("Class name", text: $classes[index].name)
                        TextField("Room number", text: $classes[index].room)
                    }
                }
                
                // Privacy Policy Section
                Section {
                    if let url = URL(string: "https://first-bell-privacy-policy.replit.app") {
                        Link("Privacy Policy", destination: url)
                            .foregroundColor(.blue)
                    } else {
                        Text("Privacy Policy")
                            .foregroundColor(.gray)
                    }
                } footer: {
                    Text("View our privacy policy to learn how your schedule data is handled.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Edit Schedule")
            .toolbar {
                Button("Save") { saveClasses() }
            }
        }
        .onAppear { loadClasses() }
    }
    
    private func saveClasses() {
        if let encoded = try? JSONEncoder().encode(classes) {
            classesData = encoded
        }
    }
    
    private func loadClasses() {
        if let decoded = try? JSONDecoder().decode([ClassInfo].self, from: classesData) {
            classes = decoded
        }
    }
}
