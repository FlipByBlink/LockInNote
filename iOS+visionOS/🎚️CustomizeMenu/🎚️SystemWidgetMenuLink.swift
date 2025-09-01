import SwiftUI

struct 🎚️SystemWidgetMenuLink: View {
    @EnvironmentObject var note: 📝NoteModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        NavigationLink {
            List {
                Section { 🎚AppearanceModePicker() }
#if os(iOS)
                🎚️SystemWidgetPreview()
#endif
                Section {
#if os(iOS)
                    🎚️FontSizeStepper(value: self.$note.system_fontSize)
                    🎚️PaddingStepper()
                    🎚️ContentAlignmentPicker()
#endif
                    switch self.note.system_appearanceMode {
                        case .standard:
                            🎚HierarchicalPicker(value: self.$note.system_hierarchical)
                        case .color:
                            🎚️TextColorPicker()
                            🎚️BackgroundColorPicker()
                            🎚️BackgroundGradientToggle()
                    }
#if os(iOS)
                    🎚️DoubleSizeOnLargeWidgetMenuLink()
#endif
                }
                Self.about()
            }
            .navigationTitle(self.navigationTitle)
            .animation(.default, value: self.note.system_appearanceMode)
        } label: {
#if os(iOS)
            LabeledContent {
                Image(.homeScreenExample)
                    .resizable()
                    .scaledToFit()
                    .frame(width: self.horizontalSizeClass == .compact ? 120 : 180)
                    .shadow(radius: 2, y: 1)
                    .padding(8)
            } label: {
                Label(self.horizontalSizeClass == .compact ? "System\nwidget" : "System widget",
                      systemImage: "slider.horizontal.3")
            }
#elseif os(visionOS)
            Label("Appearance", systemImage: "paintpalette")
#endif
        }
    }
}

private extension 🎚️SystemWidgetMenuLink {
    private static func about() -> some View {
#if os(iOS)
        Text("""
            __Target__
            Home screen
            Notification center
            StandBy
            Desktop
            Lock screen(iPad)
            """)
        .multilineTextAlignment(.center)
        .font(.caption)
        .foregroundStyle(.secondary)
        .frame(maxWidth: .infinity)
        .listRowBackground(Color.clear)
#elseif os(visionOS)
        EmptyView()
#endif
    }
    private var navigationTitle: LocalizedStringResource {
#if os(iOS)
        "System widget"
#elseif os(visionOS)
        "Appearance"
#endif
    }
}
