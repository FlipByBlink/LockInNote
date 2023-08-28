import SwiftUI

struct 🔗URLSchemeActionCommand: View {
    var body: some View {
        Group {
            Self.Button()
            🔗URLSchemeActionMenuLink()
            Self.Preview()
        }
        .modifier(📋AddNoteToEnvironment())
    }
    private struct Button: View {
        @EnvironmentObject var note: 📝NoteModel
        var body: some View {
            🔗URLSchemeActionButton(self.$note.text)
                .keyboardShortcut("u")
        }
    }
    private struct Preview: View {
        @EnvironmentObject var note: 📝NoteModel
        @StateObject private var model: 🔗URLSchemeActionModel = .init()
        var body: some View {
            if !self.model.leading.isEmpty {
                if let ⓤrl = self.model.url(self.note.text) {
                    Divider()
                    Text(verbatim: "\(ⓤrl)")
                }
            }
        }
    }
}
