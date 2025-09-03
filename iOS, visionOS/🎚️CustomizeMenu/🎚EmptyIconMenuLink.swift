import SwiftUI

struct 🎚EmptyIconMenuLink: View {
    @EnvironmentObject var note: 📝NoteModel
    var body: some View {
        NavigationLink {
            List {
                🎚️EmptyIconPreview()
                Section {
                    🎚️EmptyTypePicker()
                    if self.note.empty_type == .userText {
                        🎚️EmptyTextField()
                            .textFieldStyle(.roundedBorder)
                    }
                }
                .listRowSeparator(.hidden)
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
