import ActivityKit
import WidgetKit
import SwiftUI

// Define the activity attributes
struct HelloWorldActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var message: String
    }
    
    var name: String
}

// Widget configuration
struct HelloWorldWidget: Widget {
    let kind: String = "HelloWorldWidget"

    var body: some WidgetConfiguration {
        ActivityConfiguration(for: HelloWorldActivityAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello World")
                    .font(.headline)
                    .foregroundColor(.white)
                Text(context.state.message)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding()
            .background(Color.blue.gradient)
            .cornerRadius(12)
            .activityBackgroundTint(Color.blue)
            .activitySystemActionForegroundColor(Color.white)
            
        } dynamicIsland: { context in
            // Dynamic Island UI
            DynamicIsland {
                // Expanded UI goes here
                DynamicIslandExpandedRegion(.leading) {
                    Text("Hello")
                        .foregroundColor(.white)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("World")
                        .foregroundColor(.white)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text(context.state.message)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                }
            } compactLeading: {
                Text("HW")
                    .font(.caption2)
                    .foregroundColor(.white)
            } compactTrailing: {
                Text("🌍")
            } minimal: {
                Text("🌍")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.blue)
        }
    }
}
