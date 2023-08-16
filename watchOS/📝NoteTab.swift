import SwiftUI

struct 📝NoteTab: View {
    @EnvironmentObject var app: 📱AppModel
    @EnvironmentObject var note: 📝NoteModel
    var body: some View {
        VStack {
            Spacer()
            TextField("Input text", text: self.$note.text)
                .font(.title3)
            Spacer()
            HStack {
                Button(role: .destructive) {
                    self.note.text = ""
                    //self.📱.widgetsModel.sendWCMessageWithNewText()
                    WKInterfaceDevice.current().play(.success)
                } label: {
                    Image(systemName: "trash")
                        .fontWeight(.medium)
                }
                .disabled(self.note.text.isEmpty)
                Button {
                    self.app.sheet = .fullText
                    WKInterfaceDevice.current().play(.directionUp)
                } label: {
                    Image(systemName: "doc.text.magnifyingglass")
                        .fontWeight(.medium)
                        .foregroundStyle(self.note.text.isEmpty ? .secondary : .primary)
                }
                .disabled(self.note.text.isEmpty)
                Button {
                    self.app.sheet = .customize(self.note.family)
                    WKInterfaceDevice.current().play(.directionUp)
                } label: {
                    Image(systemName: "slider.horizontal.3")
                        .fontWeight(.medium)
                }
            }
        }
        .onChange(of: self.note.text) { self.note.save(.text, $0) }
        .onOpenURL(perform: self.handleFocus(_:))
    }
    private func handleFocus(_ ⓤrl: URL) {
        do {
            try self.app.handle(self.note.family, ⓤrl)
        } catch {
            switch error as? 📱AppModel.HandleError {
                case .customizing, .notTarget: break
                case .urlDecodeFailed, .none: assertionFailure()
            }
        }
    }
}
