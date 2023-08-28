import SwiftUI

struct 🪧AccessoryCornerView: View {
    @EnvironmentObject var note: 📝NoteModel
    var body: some View {
        Group {
            if self.note.text.isEmpty {
                if self.note.empty_type == .userText {
                    if self.note.empty_userText.isEmpty {
                        Image(systemName: "text.justify.leading")
                            .widgetLabel("Empty")
                    } else {
                        Image(systemName: "text.justify.leading")
                            .widgetLabel(self.note.empty_userText)
                    }
                } else {
                    🪧EmptyIconView()
                }
            } else {
                Image(systemName: "text.justify.leading")
                    .opacity(self.note.empty_type == .nothing ? 0 : 1)
                    .widgetLabel(self.note.text)
            }
        }
        .font(.title3.weight(.semibold))
    }
}
