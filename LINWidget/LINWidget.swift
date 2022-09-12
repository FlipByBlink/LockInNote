
import WidgetKit
import SwiftUI

@main
struct LINWidget: WidgetBundle {
    var body: some Widget {
        🖼MWWidget()
        🖼MWWidgetSub()
    }
}

struct 🖼MWWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "main", provider: 🤖Provider()) { ⓔntry in
            🅆idgetEntryView(ⓔntry)
        }
        .configurationDisplayName("LockInNote")
        .description("Show a note.")
        .supportedFamilies([.accessoryInline, .accessoryRectangular, .accessoryCircular])
    }
}

struct 🖼MWWidgetSub: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "sub", provider: 🤖Provider()) { ⓔntry in
            🅆idgetEntryView(ⓔntry)
        }
        .configurationDisplayName("Sub widget")
        .description("This is spare widget for the purpose of second widget.")
        .supportedFamilies([.accessoryRectangular, .accessoryCircular])
    }
}

struct 🤖Provider: TimelineProvider {
    func placeholder(in context: Context) -> 🕒Entry {
        🕒Entry(.now)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (🕒Entry) -> ()) {
        completion(🕒Entry(.now))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var ⓔntries: [🕒Entry] = []
        for ⓒount in 0 ..< 12 {
            let ⓞffset = ⓒount * 5
            let ⓓate = Calendar.current.date(byAdding: .minute, value: ⓞffset, to: .now)!
            ⓔntries.append(🕒Entry(ⓓate))
        }
        completion(Timeline(entries: ⓔntries, policy: .atEnd))
    }
}

struct 🕒Entry: TimelineEntry {
    let date: Date
    
    init(_ date: Date) {
        self.date = date
    }
}

struct 🅆idgetEntryView : View {
    var ⓔntry: 🤖Provider.Entry
    @Environment(\.widgetFamily) var ⓕamily: WidgetFamily
    
    @ViewBuilder
    var body: some View {
        switch ⓕamily {
            case .accessoryInline:
                Text("accessoryInline")
                    .widgetURL(URL(string: UUID().uuidString)!)
            case .accessoryRectangular:
                VStack {
                    Text("headline")
                        .font(.headline)
                    Text("accessoryRectangular")
                        .font(.subheadline)
                        .widgetURL(URL(string: UUID().uuidString)!)
                }
            case .accessoryCircular:
                ZStack {
                    AccessoryWidgetBackground()
                    Text("accessoryCircular")
                        .widgetURL(URL(string: UUID().uuidString)!)
                }
            default:
                Text("🐛")
        }
    }
    
    init(_ ⓔntry: 🤖Provider.Entry) {
        self.ⓔntry = ⓔntry
    }
}
