import SwiftUI

struct 🪧EmptyIconView: View {
    @EnvironmentObject var note: 📝NoteModel
    var body: some View {
        switch self.note.empty_type {
            case .squareAndPencil, .ellipsis, .pencil:
                Image(systemName: self.note.empty_type.icon)
                    .imageScale(.large)
            case .userText:
                if self.note.empty_userText.isEmpty {
                    Text("Empty")
                } else {
                    Text(self.note.empty_userText)
                }
            case .nothing:
                EmptyView()
        }
    }
}
