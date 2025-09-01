import SwiftUI

struct 🎚️TitleTextFieldLink: View {
    @EnvironmentObject var note: 📝NoteModel
    var body: some View {
        Section {
            NavigationLink {
                List {
                    🎚️TitleTextField()
                        .textFieldStyle(.roundedBorder)
                }
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
