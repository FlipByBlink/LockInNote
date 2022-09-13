
import WidgetKit
import SwiftUI

@main
struct LINWidgetBundle: WidgetBundle {
    var body: some Widget {
        🅁ectangularWidget()
        🄸nlineWidget()
        🄲ircularWidget()
    }
}

struct 🅁ectangularWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "Rectangular", provider: 🤖Provider()) { ⓔntry in
            🅁ectangularView(ⓔntry)
        }
        .configurationDisplayName("Rectangular widget.")
        .description("Show a note.")
        .supportedFamilies([.accessoryRectangular])
    }
}

struct 🄸nlineWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "Inline", provider: 🤖Provider()) { ⓔntry in
            🄸nlineView(ⓔntry)
        }
        .configurationDisplayName("Inline widget")
        .description("Show a note.")
        .supportedFamilies([.accessoryInline])
    }
}

struct 🄲ircularWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "Circular", provider: 🤖Provider()) { ⓔntry in
            🄲ircularView(ⓔntry)
        }
        .configurationDisplayName("Circular widget.")
        .description("Show a note.")
        .supportedFamilies([.accessoryCircular])
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
        completion(Timeline(entries: [🕒Entry(.now)], policy: .never))
    }
}

struct 🕒Entry: TimelineEntry {
    let date: Date
    
    init(_ date: Date) {
        self.date = date
    }
}

struct 🅁ectangularView : View {
    var ⓔntry: 🤖Provider.Entry
    let 📱 = 📱AppModel()
    
    var body: some View {
        Group {
            if 📱.🎛RectangularData.text != "" {
                Text(📱.🎛RectangularData.text)
                    .italic(📱.🎛RectangularData.italic)
                    .multilineTextAlignment(📱.🎛RectangularData.multilineTextAlignment.value)
            } else {
                Image(systemName: 📱.🎛RectangularData.placeholder.icon)
            }
        }
        .font(.system(size: CGFloat(📱.🎛RectangularData.fontSize),
                      weight: 📱.🎛RectangularData.fontWeight.value,
                      design: 📱.🎛RectangularData.fontDesign.value))
        .foregroundStyle(📱.🎛RectangularData.level.value)
        .widgetURL(URL(string: "Rectangular")!)
    }
    
    init(_ ⓔntry: 🤖Provider.Entry) {
        self.ⓔntry = ⓔntry
    }
}

struct 🄸nlineView : View {
    var ⓔntry: 🤖Provider.Entry
    let 📱 = 📱AppModel()
    
    var body: some View {
        Group {
            if 📱.🎛InlineData.text != "" {
                Text(📱.🎛InlineData.text)
            } else {
                Image(systemName: 📱.🎛InlineData.placeholder.icon)
            }
        }
        .widgetURL(URL(string: "Inline")!)
    }
    
    init(_ ⓔntry: 🤖Provider.Entry) {
        self.ⓔntry = ⓔntry
    }
}

struct 🄲ircularView : View {
    var ⓔntry: 🤖Provider.Entry
    let 📱 = 📱AppModel()
    
    var body: some View {
        Group {
            if 📱.🎛CircularData.text != "" {
                ZStack {
                    if 📱.🎛CircularData.background {
                        AccessoryWidgetBackground()
                    }
                    Text(📱.🎛CircularData.text)
                        .italic(📱.🎛CircularData.italic)
                        .multilineTextAlignment(📱.🎛CircularData.multilineTextAlignment.value)
                }
            } else {
                ZStack {
                    if 📱.🎛CircularData.background {
                        AccessoryWidgetBackground()
                    }
                    Image(systemName: 📱.🎛CircularData.placeholder.icon)
                }
            }
        }
        .font(.system(size: CGFloat(📱.🎛CircularData.fontSize),
                      weight: 📱.🎛CircularData.fontWeight.value,
                      design: 📱.🎛CircularData.fontDesign.value))
        .foregroundStyle(📱.🎛CircularData.level.value)
        .widgetURL(URL(string: "Circular")!)
    }
    
    init(_ ⓔntry: 🤖Provider.Entry) {
        self.ⓔntry = ⓔntry
    }
}
