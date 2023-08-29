import SwiftUI

struct 🪧EmptyIconView: View {
    @EnvironmentObject var note: 📝NoteModel
    var body: some View {
        GeometryReader { ⓟroxy in
            ZStack {
                Color.clear
                Group {
                    switch self.note.empty_type {
                        case .squareAndPencil, .ellipsis, .pencil:
                            Image(systemName: self.note.empty_type.icon)
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
                .font(.system(size: ⓟroxy.size.height * self.note.empty_iconSize.value,
                              weight: self.note.system_fontWeight.value,
                              design: self.note.system_fontDesign.value))
                .minimumScaleFactor(0.5)
                .lineLimit(1)
            }
        }
        .animation(.default, value: self.note.empty_type)
        .animation(.default, value: self.note.empty_iconSize)
    }
}
