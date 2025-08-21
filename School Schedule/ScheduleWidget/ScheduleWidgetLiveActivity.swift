import ActivityKit
import WidgetKit
import SwiftUI

struct ScheduleWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ScheduleAttributes.self) { context in
            // ✨ Minimalistic Design with Pastel Colors
            ZStack {
                // Adaptive background based on system appearance
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemBackground))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(
                                Color(.separator).opacity(0.3),
                                lineWidth: 0.5
                            )
                    )
                    .shadow(color: Color.primary.opacity(0.05), radius: 8, x: 0, y: 2)
                
                VStack(spacing: 18) {
                    // 📚 Current Block Section - Clean & Minimal
                    HStack(spacing: 16) {
                        // Subtle icon with pastel background
                        ZStack {
                            Circle()
                                .fill(
                                    context.state.isBreak ?
                                        Color(red: 0.85, green: 0.95, blue: 0.85) :
                                        Color(red: 0.88, green: 0.96, blue: 0.88)
                                )
                                .frame(width: 44, height: 44)
                            
                            Image(systemName: context.state.isBreak ? "pause.fill" : "book.closed.fill")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(
                                    context.state.isBreak ?
                                        Color(red: 0.4, green: 0.7, blue: 0.4) :
                                        Color(red: 0.3, green: 0.65, blue: 0.35)
                                )
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(context.state.currentBlock)
                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                                .foregroundColor(.primary)
                                .lineLimit(1)
                            
                            if !context.state.currentRoom.isEmpty {
                                HStack(spacing: 4) {
                                    Circle()
                                        .fill(Color(red: 0.6, green: 0.8, blue: 0.6))
                                        .frame(width: 4, height: 4)
                                    
                                    Text("Room \(context.state.currentRoom)")
                                        .font(.system(size: 13, weight: .medium, design: .rounded))
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        
                        Spacer()
                        
                        Spacer()
                        
                        // 🕐 Elegant Timer Design
                        HStack(alignment: .firstTextBaseline, spacing: 2) {
                            Text(context.state.blockEndTime, style: .timer)
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                                .monospacedDigit()
                                .foregroundColor(getTimerColor(for: context.state.blockEndTime))
                            
                            Text("left")
                                .font(.system(size: 13, weight: .medium, design: .rounded))
                                .foregroundColor(getTimerColor(for: context.state.blockEndTime).opacity(0.7))
                                .textCase(.lowercase)
                                .offset(y: 2)
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(getTimerColor(for: context.state.blockEndTime).opacity(0.08))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14)
                                        .strokeBorder(getTimerColor(for: context.state.blockEndTime).opacity(0.15), lineWidth: 1)
                                )
                        )
                    }
                    
                    // 📅 Next Block Section - Simplified
                    if !context.state.nextBlock.isEmpty {
                        // Subtle divider line
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color.clear,
                                        Color(red: 0.85, green: 0.9, blue: 0.85).opacity(0.6),
                                        Color.clear
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(height: 1)
                        
                        HStack(spacing: 12) {
                            // Simple next indicator
                            Circle()
                                .fill(Color(red: 0.95, green: 0.9, blue: 0.75))
                                .frame(width: 28, height: 28)
                                .overlay(
                                    Image(systemName: "arrow.right")
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundColor(Color(red: 0.8, green: 0.65, blue: 0.3))
                                )
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Next")
                                    .font(.system(size: 10, weight: .semibold, design: .rounded))
                                    .foregroundColor(.secondary)
                                    .textCase(.uppercase)
                                    .tracking(0.5)
                                
                                Text(context.state.nextBlock)
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .foregroundColor(.primary)
                                    .lineLimit(1)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing, spacing: 2) {
                                if let nextStart = context.state.nextBlockStartTime {
                                    Text(nextStart, format: .dateTime.hour().minute())
                                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                                        .foregroundColor(Color(red: 0.8, green: 0.65, blue: 0.3))
                                }
                                
                                if !context.state.nextRoom.isEmpty {
                                    Text("Room \(context.state.nextRoom)")
                                        .font(.system(size: 11, weight: .medium, design: .rounded))
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                }
                .padding(18)
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
        } dynamicIsland: { context in
            DynamicIsland {
                // 🏝️ Refined Dynamic Island
                DynamicIslandExpandedRegion(.leading) {
                    HStack(spacing: 6) {
                        Image(systemName: context.state.isBreak ? "pause.fill" : "book.closed.fill")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(context.state.isBreak ?
                                Color(red: 0.4, green: 0.7, blue: 0.4) :
                                Color(red: 0.3, green: 0.65, blue: 0.35))
                        
                        VStack(alignment: .leading, spacing: 1) {
                            Text(context.state.currentBlock)
                                .font(.system(size: 13, weight: .semibold, design: .rounded))
                                .lineLimit(1)
                            
                            if !context.state.currentRoom.isEmpty {
                                Text("Room \(context.state.currentRoom)")
                                    .font(.system(size: 10, weight: .medium, design: .rounded))
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                
                DynamicIslandExpandedRegion(.trailing) {
                    VStack(alignment: .trailing, spacing: 2) {
                        Text(context.state.blockEndTime, style: .timer)
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .monospacedDigit()
                            .foregroundColor(getTimerColor(for: context.state.blockEndTime))
                        
                        Text("left")
                            .font(.system(size: 9, weight: .medium, design: .rounded))
                            .foregroundColor(.secondary)
                    }
                }
                
                DynamicIslandExpandedRegion(.bottom) {
                    if !context.state.nextBlock.isEmpty {
                        HStack {
                            VStack(alignment: .leading, spacing: 1) {
                                Text("Next")
                                    .font(.system(size: 10, weight: .semibold, design: .rounded))
                                    .foregroundColor(.secondary)
                                    .textCase(.uppercase)
                                
                                Text(context.state.nextBlock)
                                    .font(.system(size: 12, weight: .medium, design: .rounded))
                                    .lineLimit(1)
                            }
                            
                            Spacer()
                            
                            if let nextStart = context.state.nextBlockStartTime {
                                Text(nextStart, format: .dateTime.hour().minute())
                                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                                    .foregroundColor(Color(red: 0.8, green: 0.65, blue: 0.3))
                            }
                        }
                        .padding(.horizontal, 4)
                    }
                }
                
            } compactLeading: {
                HStack(spacing: 3) {
                    Image(systemName: context.state.isBreak ? "pause.fill" : "book.closed.fill")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(context.state.isBreak ?
                            Color(red: 0.4, green: 0.7, blue: 0.4) :
                            Color(red: 0.3, green: 0.65, blue: 0.35))
                    
                    Text(String(context.state.currentBlock.prefix(6)))
                        .font(.system(size: 11, weight: .semibold, design: .rounded))
                        .lineLimit(1)
                }
                
            } compactTrailing: {
                Text(context.state.blockEndTime, style: .timer)
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                    .monospacedDigit()
                    .foregroundColor(getTimerColor(for: context.state.blockEndTime))
                
            } minimal: {
                ZStack {
                    Circle()
                        .fill(context.state.isBreak ?
                            Color(red: 0.4, green: 0.7, blue: 0.4) :
                            Color(red: 0.3, green: 0.65, blue: 0.35))
                        .frame(width: 18, height: 18)
                    
                    Image(systemName: context.state.isBreak ? "pause.fill" : "book.closed.fill")
                        .font(.system(size: 9, weight: .medium))
                        .foregroundColor(.white)
                }
            }
            .keylineTint(context.state.isBreak ?
                Color(red: 0.4, green: 0.7, blue: 0.4) :
                Color(red: 0.3, green: 0.65, blue: 0.35))
        }
    }
    
    // 🎨 Refined pastel color system
    private func getTimerColor(for endTime: Date) -> Color {
        let timeRemaining = endTime.timeIntervalSinceNow
        let minutes = timeRemaining / 60
        
        if minutes > 10 {
            return Color(red: 0.4, green: 0.75, blue: 0.45)      // Soft pastel green
        } else if minutes > 5 {
            return Color(red: 0.9, green: 0.7, blue: 0.35)       // Warm pastel yellow
        } else {
            return Color(red: 0.85, green: 0.45, blue: 0.4)      // Gentle pastel red
        }
    }
}
