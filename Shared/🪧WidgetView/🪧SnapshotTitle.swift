import SwiftUI

struct 🪧SnapshotTitle: ViewModifier {
    @EnvironmentObject var note: 📝NoteModel
    @Environment(\.widgetFamily) var widgetFamily
    var situation: 🪧ViewSituation
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottom) {
                if self.situation == .snapshot {
                    if self.note.title != self.note.family.presetTitle {
                        switch self.widgetFamily {
#if os(iOS) || os(macOS)
                            case .systemSmall, .systemMedium, .systemLarge, .systemExtraLarge:
                                Text(self.note.title)
                                    .fontWeight(.semibold)
                                    .padding(8)
                                    .foregroundStyle(.secondary)
                                    .background(.regularMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
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
    init(_ situation: 🪧ViewSituation) {
        self.situation = situation
    }
}
