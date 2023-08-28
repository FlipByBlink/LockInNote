import WidgetKit
import SwiftUI

private struct 🪧Provider: TimelineProvider {
    func placeholder(in context: Context) -> 🪧Entry { .init(situation: .placeholder) }
    func getSnapshot(in context: Context, completion: @escaping (🪧Entry) -> ()) { completion(.init(situation: .snapshot)) }
    func getTimeline(in context: Context, completion: @escaping (Timeline<🪧Entry>) -> ()) {
        completion(Timeline(entries: [.init(situation: .timeline)],
                            policy: .after(.now.addingTimeInterval(60 * 15))))
    }
}

private struct 🪧Entry: TimelineEntry {
    let date: Date = .now
    var situation: 🪧ViewSituation
}

struct 🪧WidgetConfiguration: WidgetConfiguration {
    var noteFamily: 📝NoteFamily
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: self.kind, provider: 🪧Provider()) { ⓔntry in
            if ⓔntry.situation == .placeholder {
                🪧PlaceholderView()
            } else {
                🪧EntryView(ⓔntry.situation)
                    .environmentObject(📝NoteModel(self.noteFamily, observeChange: false))
            }
        }
        .configurationDisplayName(self.noteFamily.presetTitleOnSystemUI)
        .description(self.noteFamily.widgetDescription)
#if os(iOS)
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge, .systemExtraLarge,
                            .accessoryInline, .accessoryCircular, .accessoryRectangular])
#elseif os(watchOS)
        .supportedFamilies([.accessoryInline, .accessoryCircular, .accessoryRectangular, .accessoryCorner])
#elseif os(macOS)
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
#endif
        .contentMarginsDisabled()
    }
    private var kind: String { 🗄️MigrationFromVer_1_1.widgetKind(self.noteFamily) }
}
