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
    private let ⓜodel = 🎛WidgetsModel()
    var body: some View {
        Text(ⓜodel.rectangular.text)
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
    }
}
