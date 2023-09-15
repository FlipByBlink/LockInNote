import SwiftUI

struct 🎚️CustomizeMenu: View {
    @State private var selection: Self.Selection = .systemWidget
    var body: some View {
        NavigationSplitView {
            List(selection: self.$selection) {
                Label("Widget", systemImage: "app")
                    .tag(Self.Selection.systemWidget)
                Label("Empty icon", systemImage: "square.dotted")
                    .tag(Self.Selection.emptyIcon)
                Divider()
                Label("Widget title", systemImage: "tag")
                    .tag(Self.Selection.widgetTitle)
            }
            .frame(minWidth: 160)
        } detail: {
            Group {
                switch self.selection {
                    case .systemWidget: Self.SystemWidgetMenu()
                    case .emptyIcon: Self.EmptyIconMenu()
                    case .widgetTitle: Self.WidgetTitleMenu()
                }
            }
            .modifier(🎚️SaveValues())
            .modifier(📋AddNoteToEnvironment())
        }
    }
    private enum Selection {
        case systemWidget, emptyIcon, widgetTitle
    }
}

private extension 🎚️CustomizeMenu {
    private struct SystemWidgetMenu: View {
        @EnvironmentObject var note: 📝NoteModel
        var body: some View {
            Form {
                Section { 🎚AppearanceModePicker() }
                🎚️SystemWidgetPreview()
                Section {
                    🎚️FontSizeStepper(value: self.$note.system_fontSize)
                    🎚FontWeightPicker()
                    🎚FontDesignPicker()
                    🎚ItalicToggle()
                    🎚MultilineTextAlignmentPicker()
                    🎚️PaddingStepper()
                    🎚️ContentAlignmentPicker()
                    Divider()
                    switch self.note.system_appearanceMode {
                        case .standard:
                            🎚HierarchicalPicker(value: self.$note.system_hierarchical)
                        case .color:
                            🎚️TextColorPicker()
                            🎚️BackgroundColorPicker()
                            🎚️BackgroundGradientToggle()
                    }
                }
                Divider()
                🎚️DoubleSizeOnLargeWidgetToggle()
            }
            .padding(32)
            .navigationTitle("Customize \"\(self.note.title)\"")
            .navigationSubtitle("Desktop, Notification center, Home screen, StandBy, Lock screen(iPad)")
            .animation(.default, value: self.note.system_appearanceMode)
            .frame(minWidth: 620)
        }
    }
    private struct EmptyIconMenu: View {
        @EnvironmentObject var note: 📝NoteModel
        var body: some View {
            Form {
                🎚️EmptyIconPreview()
                Section {
                    🎚️EmptyTypePicker()
                    if self.note.empty_type == .userText {
                        🎚️EmptyTextField()
                    }
                }
                if self.note.empty_type != .nothing {
                    Section { 🎚️EmptyIconSizePicker() }
                }
            }
            .padding(32)
            .navigationTitle("Customize \"\(self.note.title)\" - Empty icon")
            .navigationSubtitle("No text situation")
            .animation(.default, value: self.note.empty_type)
        }
    }
    private struct WidgetTitleMenu: View {
        @EnvironmentObject var note: 📝NoteModel
        var body: some View {
            Form {
                🎚️TitleTextField()
                    .font(.title2)
                    .padding(32)
            }
            .navigationTitle("Customize \"\(self.note.title)\" - Widget title")
        }
    }
}
