import SwiftUI
import WidgetKit

struct 🪧EntryView: View {
    var situation: 🪧ViewSituation
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
        .widgetURL(self.note.family.widgetURL)
        .modifier(🪧SnapshotTitle(self.situation))
    }
    init(_ situation: 🪧ViewSituation) {
        self.situation = situation
    }
}

enum 🪧ViewSituation {
    case timeline, snapshot, placeholder
}
