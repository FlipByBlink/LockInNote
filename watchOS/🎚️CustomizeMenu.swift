import SwiftUI

struct 🎚️CustomizeMenu: View {
    @EnvironmentObject var app: 📱AppModel
    var noteFamily: 📝NoteFamily
    var body: some View {
        switch self.noteFamily {
            case .primary: Self.Content().environmentObject(self.app.primaryNote)
            case .secondary: Self.Content().environmentObject(self.app.secondaryNote)
            case .tertiary: Self.Content().environmentObject(self.app.tertiaryNote)
        }
    }
    init(_ noteFamily: 📝NoteFamily) {
        self.noteFamily = noteFamily
    }
    private struct Content: View {
        @EnvironmentObject var note: 📝NoteModel
        var body: some View {
            NavigationStack {
                List {
                    🎚️AccessoryWidgetPreview()
                    Section {
                        🎚️FontSizePicker(value: self.$note.accessory_fontSize)
                        🎚FontWeightPicker(value: self.$note.accessory_fontWeight)
                        🎚FontDesignPicker(value: self.$note.accessory_fontDesign)
                        🎚MultilineTextAlignmentPicker(value: self.$note.accessory_multilineTextAlignment)
                        🎚ItalicToggle(value: self.$note.accessory_italic)
                        🎚HierarchicalPicker(value: self.$note.accessory_hierarchical)
                    }
                    🎚️EmptyContentMenuLink()
                }
                .navigationTitle("Customize \"\(self.note.title)\"")
            }
            .modifier(🎚️SaveValues())
        }
    }
}

private struct 🎚️FontSizePicker: View {
    @Binding var value: Int
    var body: some View {
        Picker(selection: self.$value) {
            ForEach(8 ..< 40, id: \.self) {
                Text("\($0)")
                    .font(.system(size: CGFloat($0)))
            }
        } label: {
            Label("Size", systemImage: "textformat.size")
        }
    }
}

private struct 🎚️EmptyContentMenuLink: View {
    @EnvironmentObject var note: 📝NoteModel
    var body: some View {
        Section {
            NavigationLink {
                List {
                    🎚️EmptyContentPreview()
                    Section {
                        🎚️EmptyTypePicker()
                        if self.note.empty_type == .userText {
                            🎚️EmptyTextField()
                        }
                    }
                }
                .navigationTitle("Empty content")
                .animation(.default, value: self.note.empty_type)
            } label: {
                Label("Empty content", systemImage: "questionmark")
            }
        }
    }
}
