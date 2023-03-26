import WidgetKit
import SwiftUI

struct 🄿rovider: TimelineProvider {
    func placeholder(in context: Context) -> 🅂impleEntry {
        🅂impleEntry(date: .now)
    }

    func getSnapshot(in context: Context, completion: @escaping (🅂impleEntry) -> ()) {
        completion(🅂impleEntry(date: .now))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        completion(Timeline(entries: [🅂impleEntry(date: .now)], policy: .never))
    }
}

struct 🅂impleEntry: TimelineEntry {
    let date: Date
}

struct 🄴ntryView : View {
    var entry: 🄿rovider.Entry
    private let 🎛 = 🎛WidgetsModel().rectangular
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

@main
struct LINComplication: Widget {
    let kind: String = "LINComplication"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: 🄿rovider()) { ⓔntry in
            🄴ntryView(entry: ⓔntry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.accessoryInline,
                            .accessoryRectangular,
                            .accessoryCircular,
                            .accessoryCorner])
    }
}
