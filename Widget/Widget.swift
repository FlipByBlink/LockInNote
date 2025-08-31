import WidgetKit
import SwiftUI

private struct 🪧Provider: TimelineProvider {
    func placeholder(in context: Context) -> 🪧Entry { 
        .init(situation: .placeholder)
    }
    func getSnapshot(in context: Context, completion: @escaping (🪧Entry) -> ()) {
        completion(.init(situation: .snapshot))
    }
    func getTimeline(in context: Context, completion: @escaping (Timeline<🪧Entry>) -> ()) {
        completion(Timeline(entries: [.init(situation: .timeline)],
                            policy: .after(.now.addingTimeInterval(60 * 20))))
    }
}

private struct 🪧Entry: TimelineEntry {
    let date: Date = .now
    var situation: 🪧Situation
}

struct 🪧WidgetConfiguration: WidgetConfiguration {
    var noteFamily: 📝NoteFamily
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: self.kind, provider: 🪧Provider()) { ⓔntry in
            if ⓔntry.situation == .placeholder {
                🪧PlaceholderView()
            } else {
                🪧EntryView()
                    .environmentObject(📝NoteModel(self.noteFamily, observeChange: false))
                    .environment(\.ⓢituation, ⓔntry.situation)
            }
        }
        .configurationDisplayName(self.noteFamily.presetTitleOnSystemUI)
        .description(self.noteFamily.widgetDescription)
        .supportedFamilies(self.supportedFamilies)
        .contentMarginsDisabled()
    }
    private var kind: String { 🗄️MigrationFromVer_1_1.widgetKind(self.noteFamily) }
    private var supportedFamilies: [WidgetFamily] {
#if os(iOS)
        [.systemSmall, .systemMedium, .systemLarge, .systemExtraLarge,
         .accessoryInline, .accessoryCircular, .accessoryRectangular]
#elseif os(visionOS)
        [.systemSmall, .systemMedium, .systemLarge, .systemExtraLarge,
         .systemExtraLargePortrait]
#elseif os(watchOS)
        [.accessoryInline, .accessoryCircular, .accessoryRectangular, .accessoryCorner]
#elseif os(macOS)
        if #available(macOS 14.0, *) {
            [.systemSmall, .systemMedium, .systemLarge, .systemExtraLarge]
        } else {
            [.systemSmall, .systemMedium, .systemLarge]
        }
#endif
    }
}
