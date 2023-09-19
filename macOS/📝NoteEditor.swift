import SwiftUI

struct 📝NoteEditor: View {
    @EnvironmentObject var app: 📱AppModel
    @EnvironmentObject var note: 📝NoteModel
    @Environment(\.openWindow) var openWindow
    @FocusState var focus: Bool
    var body: some View {
        TextEditor(text: self.$note.text)
            .focused(self.$focus)
            .onAppear { self.focus = true }
            .clipShape(RoundedRectangle(cornerRadius: 12)) //TODO: スクロールバー表示される際に不恰好。次回のアップデートで修正する。
            .font(.title)
            .padding(.top, 4)
            .padding(.horizontal)
            .padding(.bottom)
            .background(.background)
            .navigationTitle(self.note.title)
            .onChange(of: self.note.text) { self.note.save(.text, $0) }
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
                    Label("Clear note", systemImage: "trash")
                }
                .help("Clear")
                🔗URLSchemeActionButton(self.$note.text)
                //ShareLink(item: self.note.text)
                //    .help("Share note")
            }
    }
}
