import SwiftUI

#if os(iOS)
struct 🎚️AccessoryWidgetMenuLink: View {
    @EnvironmentObject var note: 📝NoteModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        NavigationLink {
            List {
                🎚️AccessoryWidgetPreview()
                Section {
                    🎚️FontSizeStepper(value: self.$note.accessory_fontSize)
                    🎚HierarchicalPicker(value: self.$note.accessory_hierarchical)
                    if #unavailable(iOS 17.0) {
                        NavigationLink {
                            List { 🎚️AccessaryCircularBackgroundToggleForIOS16AndWatchOS() }
                                .navigationTitle("More")
                        } label: {
                            Label("More", systemImage: "ellipsis")
                        }
                    }
                }
                Self.about()
            }
            .navigationTitle("Accessory widget")
        } label: {
            LabeledContent {
                Image(.lockScreenExample)
                    .resizable()
                    .scaledToFit()
                    .frame(width: self.horizontalSizeClass == .compact ? 120 : 180)
                    .shadow(radius: 2, y: 1)
                    .padding(8)
            } label: {
                Label(self.horizontalSizeClass == .compact ? "Accessory\nwidget" : "Accessory widget",
                      systemImage: "slider.horizontal.3")
            }
        }
    }
    private static func about() -> some View {
        Text("""
            __Target__
            Lock screen
            Apple Watch complication
            """)
        .multilineTextAlignment(.center)
        .font(.caption)
        .foregroundStyle(.secondary)
        .frame(maxWidth: .infinity)
        .listRowBackground(Color.clear)
    }
}
#endif
