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
                    self.note.text.removeAll()
                    WKInterfaceDevice.current().play(.success)
                } label: {
                    Label("Clear note", systemImage: "trash")
                        .fontWeight(.medium)
                }
                .disabled(self.note.text.isEmpty)
                Button {
                    self.app.sheet = .noteDetail
                    WKInterfaceDevice.current().play(.directionUp)
                } label: {
                    Label("Detail", systemImage: "doc.text.magnifyingglass")
                        .fontWeight(.medium)
                        .foregroundStyle(self.note.text.isEmpty ? .secondary : .primary)
                }
                .disabled(self.note.text.isEmpty)
                Button {
                    self.app.sheet = .customize(self.note.family)
                    WKInterfaceDevice.current().play(.directionUp)
                } label: {
                    Label("Customize", systemImage: "slider.horizontal.3")
                        .fontWeight(.medium)
                }
            }
            .labelStyle(.iconOnly)
        }
        .onChange(of: self.note.text) { self.note.save(.text, $0) }
        .onOpenURL(perform: self.handleFocus(_:))
        .tag(🔖Tab.note(self.note.family))
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
