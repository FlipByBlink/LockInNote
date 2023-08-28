import SwiftUI

struct 🔗URLSchemeActionButton: View {
    @StateObject private var model: 🔗URLSchemeActionModel = .init()
    @Environment(\.openURL) var openURL
    @Binding var query: String
    var body: some View {
        if !self.model.leading.isEmpty {
            if let ⓤrl = self.model.url(self.query) {
#if os(iOS)
                Section {
                    self.button(ⓤrl)
                } footer: {
                    Text(verbatim: "\(ⓤrl)")
                }
#elseif os(macOS)
                self.button(ⓤrl)
#endif
            }
        }
    }
    private func button(_ ⓤrl: URL) -> some View {
        Button {
            self.openURL(ⓤrl) { ⓐccepted in
                if ⓐccepted && self.model.eraseTextAfterAction {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.query = ""
                    }
                }
            }
        } label: {
            Label(self.model.buttonTitle, systemImage: "command")
                .font(.headline)
        }
        .disabled(self.query.isEmpty)
        .help(self.model.buttonTitle)
    }
    init(_ query: Binding<String>) {
        self._query = query
    }
}
