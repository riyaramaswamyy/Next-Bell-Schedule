import Foundation
import ActivityKit

struct ClassInfo: Codable {
    var name: String
    var room: String
}

struct ScheduleBlock: Identifiable, Codable {
    var id: String = UUID().uuidString
    let name: String
    let start: String // "h:mm a" e.g. "8:35 AM"
    let end: String   // "h:mm a"
}

// 🔥 THE MAGIC: Pass actual dates instead of countdown strings!
struct ScheduleAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var currentBlock: String
        var currentRoom: String
        var blockEndTime: Date        // 🎯 Auto-updating countdown!
        var nextBlock: String
        var nextRoom: String
        var nextBlockStartTime: Date? // For "Next at X:XX" display
        var isBreak: Bool = false     // To show different styling
    }
    
    var name: String
}
