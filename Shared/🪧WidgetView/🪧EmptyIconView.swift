import SwiftUI

struct 🪧EmptyIconView: View {
    @EnvironmentObject var note: 📝NoteModel
    var body: some View {
        ZStack {
            switch self.note.empty_type {
                case .squareAndPencil, .ellipsis, .pencil:
                    Image(systemName: self.note.empty_type.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .font(.system(.body,
                                      design: self.note.system_fontDesign.value,
                                      weight: self.note.system_fontWeight.value))
                        .scaleEffect(self.note.empty_iconSize.value)
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
        .animation(.default, value: self.note.empty_type)
        .animation(.default, value: self.note.empty_iconSize)
    }
}
