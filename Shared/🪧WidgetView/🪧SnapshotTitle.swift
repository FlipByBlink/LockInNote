import SwiftUI

struct 🪧SnapshotTitle: ViewModifier {
    @EnvironmentObject var note: 📝NoteModel
    @Environment(\.widgetFamily) var widgetFamily
    @Environment(\.ⓢituation) var situation
    private var condition: Bool {
        self.situation == .snapshot
        && !self.note.title.isEmpty
        && self.note.title != self.note.family.presetTitle
    }
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottom) {
                if self.condition {
                    switch self.widgetFamily {
#if os(iOS) || os(macOS)
                        case .systemSmall, .systemMedium, .systemLarge, .systemExtraLarge:
                            Text(self.note.title)
                                .font(.caption)
                                .fontWeight(.medium)
                                .padding(4)
                                .foregroundStyle(.secondary)
                                .background(.regularMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                                .padding(8)
#endif
#if os(iOS) || os(watchOS)
                        case .accessoryCircular, .accessoryRectangular:
                            Text(self.note.title)
                                .underline()
                                .foregroundStyle(.secondary)
                                .font(.caption2.weight(.semibold))
                                .lineLimit(1)
                                .minimumScaleFactor(0.6)
#endif
                        default:
                            EmptyView()
                    }
                }
            }
    }
}
