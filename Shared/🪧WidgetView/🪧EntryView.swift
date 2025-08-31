import SwiftUI

struct 🪧EntryView: View {
    @EnvironmentObject var note: 📝NoteModel
    @Environment(\.widgetFamily) var widgetFamily
    var body: some View {
        Group {
            switch self.widgetFamily {
                case .systemSmall, .systemMedium, .systemLarge, .systemExtraLarge:
                    🪧SystemFamilyView()
#if os(visionOS)
                case .systemExtraLargePortrait:
                    🪧SystemFamilyView()
#endif
#if os(iOS) || os(watchOS)
                case .accessoryInline, .accessoryCircular, .accessoryRectangular:
                    🪧AccessoryFamilyView()
#endif
#if os(watchOS)
                case .accessoryCorner:
                    🪧AccessoryCornerView()
#endif
                default:
                    🪧PlaceholderView()
            }
        }
        .modifier(🪧ContainerBackground())
        .modifier(🪧SnapshotTitle())
        .widgetURL(self.note.family.widgetURL)
        .accessibilityLabel("Note")
    }
}
