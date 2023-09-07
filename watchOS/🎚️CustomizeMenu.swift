import SwiftUI

struct 🎚️CustomizeMenu: View {
    @EnvironmentObject var note: 📝NoteModel
    var body: some View {
        NavigationStack {
            List {
                🎚️AccessoryWidgetPreview()
                Section {
                    Self.FontSizePicker(value: self.$note.accessory_fontSize)
                    🎚FontWeightPicker()
                    🎚FontDesignPicker()
                    🎚MultilineTextAlignmentPicker()
                    🎚ItalicToggle()
                    🎚HierarchicalPicker(value: self.$note.accessory_hierarchical)
                    NavigationLink {
                        List { 🎚️AccessaryCircularBackgroundToggleForIOS16AndWatchOS() }
                    } label: {
                        Label("More", systemImage: "ellipsis")
                    }
                }
                Self.EmptyIconMenuLink()
                Self.WidgetTitleEditLink()
            }
            .navigationTitle("Customize \"\(self.note.title)\"")
        }
        .modifier(🎚️SaveValues())
    }
}

private extension 🎚️CustomizeMenu {
    private struct FontSizePicker: View {
        @Binding var value: Int
        var body: some View {
            Picker(selection: self.$value) {
                ForEach(8 ..< 40, id: \.self) {
                    Text(verbatim: "\($0)")
                        .font(.system(size: CGFloat($0)))
                }
            } label: {
                Label("Size", systemImage: "textformat.size")
            }
        }
    }
    private struct EmptyIconMenuLink: View {
        @EnvironmentObject var note: 📝NoteModel
        var body: some View {
            Section {
                NavigationLink {
                    List {
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
                    .navigationTitle("Empty icon")
                    .animation(.default, value: self.note.empty_type)
                } label: {
                    Label("Empty icon", systemImage: "questionmark")
                }
            }
        }
    }
    private struct WidgetTitleEditLink: View {
        @EnvironmentObject var note: 📝NoteModel
        var body: some View {
            NavigationLink {
                🎚️TitleTextField()
                    .navigationTitle("Widget title")
            } label: {
                LabeledContent {
                    Text(self.note.title)
                } label: {
                    Label("Widget title", systemImage: "tag")
                }
            }
        }
    }
}
