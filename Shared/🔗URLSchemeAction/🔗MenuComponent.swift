import SwiftUI

enum 🔗URLSchemeActionMenuComponent {
    struct InputView: View {
        @EnvironmentObject var model: 🔗URLSchemeActionModel
        var body: some View {
            HStack {
                Spacer()
                if self.model.leading.isEmpty {
                    Text("① +")
                        .foregroundStyle(.secondary)
                }
                Text(self.model.leading + "TEXT" + self.model.trailing)
                    .italic()
                    .monospaced()
                    .multilineTextAlignment(.center)
                    .padding(8)
                    .frame(minHeight: 100)
                if self.model.trailing.isEmpty {
                    Text("+ ②")
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }
            TextField("① URL scheme", text: self.$model.leading)
            TextField("② Trailing component", text: self.$model.trailing)
        }
    }
    struct TestButton: View {
        @EnvironmentObject var model: 🔗URLSchemeActionModel
        @Environment(\.openURL) var openURL
        var body: some View {
            Button {
                guard let ⓤrl = self.model.url("TEXT") else { return }
                self.openURL(ⓤrl)
            } label: {
                Label(self.model.buttonTitle, systemImage: "command")
                    .font(.headline)
            }
            .disabled(self.model.leading.isEmpty)
            .animation(.default, value: self.model.leading.isEmpty)
        }
    }
    struct TestButtonFooter: View {
        @EnvironmentObject var model: 🔗URLSchemeActionModel
        var body: some View {
            Text(self.model.url("TEXT")?.description ?? "TEXT")
                .opacity(self.model.leading.isEmpty ? 0 : 1)
                .animation(.default, value: self.model.leading.isEmpty)
        }
    }
    struct ButtonLabelSection: View {
        @EnvironmentObject var model: 🔗URLSchemeActionModel
        var addPrompt: Bool = false
        var body: some View {
            TextField("Button label",
                      text: self.$model.buttonCustomizeTitle,
                      prompt: self.addPrompt ? Text("Input text of button") : nil)
        }
    }
    struct EraseTextAfterActionSection: View {
        @EnvironmentObject var model: 🔗URLSchemeActionModel
        var body: some View {
            Section {
                Toggle(isOn: self.$model.eraseTextAfterAction) {
                    Label("Erase text after action", systemImage: "eraser.line.dashed")
                }
            }
        }
    }
    enum Example1 {
        struct Preview: View {
            var body: some View {
                Text(verbatim: "shortcuts://run-shortcut?name=SHORTCUTTITLE&input=text&text=TEXT")
                    .monospaced()
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                    .textSelection(.enabled)
            }
        }
        static var header: LocalizedStringKey { "Example 1" }
        struct Footer: View {
            var body: some View {
                Text("To run one shortcut of Shortcuts App with the text.")
            }
        }
    }
    enum Example2 {
        struct Preview: View {
            var body: some View {
                Text(verbatim: "https://duckduckgo.com/?q=TEXT")
                    .monospaced()
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                    .textSelection(.enabled)
            }
        }
        static var header: LocalizedStringKey { "Example 2" }
        struct Footer: View {
            var body: some View {
                Text("To search the text on DuckDuckGo.")
            }
        }
    }
    struct SampleImage: View {
        var body: some View {
            Image("urlSchemeActionExample")
                .resizable()
                .scaledToFit()
                .cornerRadius(24)
                .shadow(radius: 4)
                .padding()
        }
    }
    struct NoticeSection: View {
        var body: some View {
            Text("Not sync URL scheme between devices")
        }
    }
}
