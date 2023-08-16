import WidgetKit
import SwiftUI

@main
struct LockInNoteWidgetBundle: WidgetBundle {
    var body: some Widget {
        🅁ectangularWidget()
        🄲ircularWidget()
        🄸nlineWidget()
    }
}

struct 🅁ectangularWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "Rectangular", provider: 🤖Provider()) { _ in
            🖼️RectangularView()
        }
        .configurationDisplayName("□⃞  Rectangular")
        .description("Show a note.")
        .supportedFamilies([.accessoryRectangular])
    }
}

struct 🄲ircularWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "Circular", provider: 🤖Provider()) { _ in
            🖼️CircularView()
        }
        .configurationDisplayName("○  Circular")
        .description("Show a note.")
#if os(iOS)
        .supportedFamilies([.accessoryCircular])
#elseif os(watchOS)
        .supportedFamilies([.accessoryCircular, .accessoryCorner])
#endif
    }
}

struct 🄸nlineWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "Inline", provider: 🤖Provider()) { _ in
            🖼️InlineView()
        }
        .configurationDisplayName("▷  Inline")
        .description("Show a note.")
        .supportedFamilies([.accessoryInline])
    }
}

struct 🤖Provider: TimelineProvider {
    func placeholder(in context: Context) -> 🕒Entry {
        🕒Entry()
    }
    func getSnapshot(in context: Context, completion: @escaping (🕒Entry) -> ()) {
        completion(🕒Entry())
    }
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        completion(Timeline(entries: [🕒Entry()], policy: .never))
    }
}

struct 🕒Entry: TimelineEntry {
    let date: Date = .now
}
