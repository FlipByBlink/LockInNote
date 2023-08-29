import SwiftUI

struct 🪧EntryView: View {
    @EnvironmentObject var note: 📝NoteModel
    @Environment(\.widgetFamily) var widgetFamily
    var body: some View {
        Group {
            switch self.widgetFamily {
                case .systemSmall, .systemMedium, .systemLarge, .systemExtraLarge:
                    🪧SystemFamilyView()
                case .accessoryInline, .accessoryCircular, .accessoryRectangular:
                    🪧AccessoryFamilyView()
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
    }
}
