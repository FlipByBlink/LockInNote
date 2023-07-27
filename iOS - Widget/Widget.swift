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
            🄸nlineView()
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

struct 🅁ectangularView : View {
    private let model: 🎛RectangularWidgetModel = .load() ?? .default
    var body: some View {
        Group {
            if self.model.text != "" {
                Text(self.model.text)
                    .italic(self.model.italic)
                    .multilineTextAlignment(self.model.multilineTextAlignment.value)
            } else if self.model.placeholder != .nothing {
                Image(systemName: self.model.placeholder.icon)
                    .imageScale(.large)
            }
        }
        .font(.system(size: CGFloat(self.model.fontSize),
                      weight: self.model.fontWeight.value,
                      design: self.model.fontDesign.value))
        .foregroundStyle(self.model.level.value)
        .widgetAccentable()
        .widgetURL(🔗WidgetLink.rectangular.url)
    }
}

struct 🄲ircularView : View {
    private let model: 🎛CircularWidgetModel = .load() ?? .default
    var body: some View {
        Group {
            if self.model.text != "" {
                ZStack {
                    if self.model.background { AccessoryWidgetBackground() }
                    Text(self.model.text)
                        .italic(self.model.italic)
                        .multilineTextAlignment(self.model.multilineTextAlignment.value)
                        .padding(.horizontal, 2)
                }
            } else {
                ZStack {
                    if self.model.background { AccessoryWidgetBackground() }
                    if self.model.placeholder != .nothing {
                        Image(systemName: self.model.placeholder.icon)
                            .imageScale(.large)
                    }
                }
            }
        }
        .font(.system(size: CGFloat(self.model.fontSize),
                      weight: self.model.fontWeight.value,
                      design: self.model.fontDesign.value))
        .foregroundStyle(self.model.level.value)
        .widgetAccentable()
        .widgetURL(🔗WidgetLink.circular.url)
    }
}

struct 🄸nlineView : View {
    private let model: 🎛InlineWidgetModel = .load() ?? .default
    var body: some View {
        Group {
            if self.model.text != "" {
                Text(self.model.text)
            } else if self.model.placeholder != .nothing {
                Image(systemName: self.model.placeholder.icon)
            }
        }
        .widgetAccentable()
        .widgetURL(🔗WidgetLink.inline.url)
    }
}
