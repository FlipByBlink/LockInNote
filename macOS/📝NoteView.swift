import SwiftUI

struct 📝NoteView: View {
    @EnvironmentObject var app: 📱AppModel
    @EnvironmentObject var note: 📝NoteModel
    @Environment(\.openWindow) var openWindow
    @FocusState var focus: Bool
    var body: some View {
        TextEditor(text: self.$note.text)
            .focused(self.$focus)
            .onAppear { self.focus = true }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .font(.title)
            .padding(.top, 4)
            .padding(.horizontal)
            .padding(.bottom)
            .background(.background)
            .navigationTitle(self.note.title)
            .onChange(of: self.note.text) { 💾ICloud.save(.text, self.note.family, $0) }
            .toolbar {
                Button {
                    self.openWindow(id: "customize")
                } label: {
                    Label("Customize", systemImage: "slider.horizontal.3")
                }
                .help("Customize widget")
                Button(role: .destructive) {
                    self.note.text.removeAll()
                } label: {
                    Label("Delete note", systemImage: "trash")
                }
                .help("Delete")
                🔗URLSchemeActionButton(self.$note.text)
                ShareLink(item: self.note.text)
                    .help("Share note")
            }
    }
}
