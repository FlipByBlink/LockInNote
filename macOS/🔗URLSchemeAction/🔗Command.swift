import SwiftUI

struct 🔗URLSchemeActionCommand: View {
    @ObservedObject var app: 📱AppModel
    var body: some View {
        switch self.app.target {
            case .primary: Self.Content().environmentObject(self.app.primaryNote)
            case .secondary: Self.Content().environmentObject(self.app.secondaryNote)
            case .tertiary: Self.Content().environmentObject(self.app.tertiaryNote)
        }
    }
    init(_ app: 📱AppModel) {
        self.app = app
    }
    private struct Content: View {
        @EnvironmentObject var note: 📝NoteModel
        @StateObject private var model: 🔗URLSchemeActionModel = .init()
        var body: some View {
            🔗URLSchemeActionButton(self.$note.text)
                .keyboardShortcut("u")
            🔗URLSchemeActionMenuLink()
            if !self.model.leading.isEmpty {
                if let ⓤrl = self.model.url(self.note.text) {
                    Divider()
                    Text("\(ⓤrl)")
                }
            }
        }
    }
}
