import WidgetKit
import SwiftUI

@main
struct LINWidgetBundle: WidgetBundle {
    var body: some Widget {
        🅁ectangularWidget()
        🄲ircularWidget()
        🄸nlineWidget()
    }
}

struct 🅁ectangularWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "Rectangular", provider: 🤖Provider()) { _ in
            🅁ectangularView()
        }
        .configurationDisplayName("□⃞  Rectangular")
        .description("Show a note.")
        .supportedFamilies([.accessoryRectangular])
    }
}

struct 🄲ircularWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "Circular", provider: 🤖Provider()) { _ in
            🄲ircularView()
        }
        .configurationDisplayName("○  Circular")
        .description("Show a note.")
        .supportedFamilies([.accessoryCircular])
    }
}

struct 🄸nlineWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "Inline", provider: 🤖Provider()) { _ in
            🄸nlineView()
        }
        .configurationDisplayName("▷  Inline")
        .description("Show a note.")
        .supportedFamilies([.accessoryInline])
    }
}

struct 🤖Provider: TimelineProvider {
    func placeholder(in context: Context) -> 🕒Entry {
        🕒Entry(date: .now)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (🕒Entry) -> ()) {
        completion(🕒Entry(date: .now))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        completion(Timeline(entries: [🕒Entry(date: .now)], policy: .never))
    }
}

struct 🕒Entry: TimelineEntry {
    let date: Date
}

struct 🅁ectangularView : View {
    private let 🎛: 🎛RectangularDataModel = .load() ?? .default
    var body: some View {
        Group {
            if 🎛.text != "" {
                Text(🎛.text)
                    .italic(🎛.italic)
                    .multilineTextAlignment(🎛.multilineTextAlignment.value)
            } else if 🎛.placeholder != .nothing {
                Image(systemName: 🎛.placeholder.icon)
                    .imageScale(.large)
            }
        }
        .font(.system(size: CGFloat(🎛.fontSize),
                      weight: 🎛.fontWeight.value,
                      design: 🎛.fontDesign.value))
        .foregroundStyle(🎛.level.value)
        .widgetURL(URL(string: "Rectangular")!)
    }
}

struct 🄲ircularView : View {
    private let 🎛: 🎛CircularDataModel = .load() ?? .default
    var body: some View {
        Group {
            if 🎛.text != "" {
                ZStack {
                    if 🎛.background { AccessoryWidgetBackground() }
                    Text(🎛.text)
                        .italic(🎛.italic)
                        .multilineTextAlignment(🎛.multilineTextAlignment.value)
                        .padding(.horizontal, 2)
                }
            } else {
                ZStack {
                    if 🎛.background { AccessoryWidgetBackground() }
                    if 🎛.placeholder != .nothing {
                        Image(systemName: 🎛.placeholder.icon)
                            .imageScale(.large)
                    }
                }
            }
        }
        .font(.system(size: CGFloat(🎛.fontSize),
                      weight: 🎛.fontWeight.value,
                      design: 🎛.fontDesign.value))
        .foregroundStyle(🎛.level.value)
        .widgetURL(URL(string: "Circular")!)
    }
}

struct 🄸nlineView : View {
    private let 🎛: 🎛InlineDataModel = .load() ?? .default
    var body: some View {
        Group {
            if 🎛.text != "" {
                Text(🎛.text)
            } else if 🎛.placeholder != .nothing {
                Image(systemName: 🎛.placeholder.icon)
            }
        }
        .widgetURL(URL(string: "Inline")!)
    }
}
