import SwiftUI

struct 🔗URLSchemeActionButton: View {
    @AppStorage("URLSchemeLeading") var leadingComponent: String = ""
    @AppStorage("URLSchemeTrailing") var trailingComponent: String = ""
    @AppStorage("URLSchemeButtonTitle") var buttonTitle: String = ""
    @AppStorage("EraseTextAfterAction") var eraseTextAfterAction: Bool = false
    @Environment(\.openURL) var openURL
    @Binding var query: String
    private var ⓤrl: URL? {
        let ⓣext = self.leadingComponent + self.query + self.trailingComponent
        if let ⓔncodedText = ⓣext.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            return URL(string: ⓔncodedText)
        } else {
            return nil
        }
    }
    var body: some View {
        if !self.leadingComponent.isEmpty {
            if let ⓤrl {
                Section {
                    Button {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        self.openURL(ⓤrl) { ⓐccepted in
                            if ⓐccepted && self.eraseTextAfterAction {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    self.query = ""
                                }
                            }
                        }
                    } label: {
                        Label(LocalizedStringKey(self.buttonTitle.isEmpty ? "URL Scheme Action" : self.buttonTitle),
                              systemImage: "command")
                        .font(.headline)
                    }
                    .disabled(self.query.isEmpty)
                } footer: {
                    Text(ⓤrl.description)
                }
            }
        }
    }
    init(_ query: Binding<String>) {
        self._query = query
    }
}

struct 🔗URLSchemeActionMenuLink: View {
    var body: some View {
        Section {
            NavigationLink {
                🔗URLSchemeActionMenu()
            } label: {
                Label("Setting URL scheme action", systemImage: "command")
            }
            HStack {
                Spacer()
                VStack {
                    Text("shortcuts://run-shortcut?nam...")
                        .rotationEffect(.degrees(-1.5))
                    Text(verbatim: "https://duckduckgo.com/?q=...")
                        .rotationEffect(.degrees(-1.5))
                    Text("etc.")
                        .rotationEffect(.degrees(-1.5))
                }
                Spacer()
            }
            .font(.subheadline.weight(.heavy).italic())
            .lineLimit(1)
            .foregroundStyle(.secondary)
            .scaleEffect(y: 1.33)
            .padding(.vertical, 32)
        }
    }
}

private struct 🔗URLSchemeActionMenu: View {
    @AppStorage("URLSchemeLeading") var leadingComponent: String = ""
    @AppStorage("URLSchemeTrailing") var trailingComponent: String = ""
    @AppStorage("URLSchemeButtonTitle") var buttonTitle: String = ""
    @AppStorage("EraseTextAfterAction") var eraseTextAfterAction: Bool = false
    var body: some View {
        List {
            Section {
                VStack {
                    HStack {
                        if self.leadingComponent.isEmpty {
                            Text("① +")
                                .foregroundStyle(.secondary)
                        }
                        Text(self.leadingComponent + "TEXT" + self.trailingComponent)
                            .italic()
                            .font(.system(.subheadline, design: .monospaced))
                            .multilineTextAlignment(.center)
                            .padding(8)
                            .frame(minHeight: 100)
                        if self.trailingComponent.isEmpty {
                            Text("+ ②")
                                .foregroundStyle(.secondary)
                        }
                    }
                    TextField("① URL scheme", text: self.$leadingComponent)
                    TextField("② Trailing component", text: self.$trailingComponent)
                        .font(.subheadline)
                        .padding(.bottom, 4)
                }
                .textFieldStyle(.roundedBorder)
            } header: {
                Text("URL scheme")
            }
            Section {
                TextField("Input text of button", text: self.$buttonTitle)
                    .textFieldStyle(.roundedBorder)
            } header: {
                Text("Button label")
            }
            Section {
                Toggle(isOn: self.$eraseTextAfterAction) {
                    Label("Erase text after action", systemImage: "eraser.line.dashed")
                }
            }
            Section {
                Text("shortcuts://run-shortcut?name=SHORTCUTTITLE&input=text&text=TEXT")
                    .font(.system(.subheadline, design: .monospaced, weight: .medium))
                    .multilineTextAlignment(.center)
                    .padding(.vertical)
                    .foregroundStyle(.secondary)
                    .textSelection(.enabled)
            } header: {
                Text("Example 1")
            } footer: {
                Text("To run one shortcut of Shortcuts App with the text.")
            }
            Section {
                HStack {
                    Spacer()
                    Text(verbatim: "https://duckduckgo.com/?q=TEXT")
                        .font(.system(.subheadline, design: .monospaced, weight: .medium))
                        .multilineTextAlignment(.center)
                        .padding(.vertical)
                        .foregroundStyle(.secondary)
                        .textSelection(.enabled)
                    Spacer()
                }
            } header: {
                Text("Example 2")
            } footer: {
                Text("To search the text on DuckDuckGo.")
            }
            Image(.urlSchemeActionExample)
                .resizable()
                .scaledToFit()
                .cornerRadius(32)
                .shadow(radius: 4)
                .padding()
                .listRowBackground(Color.clear)
        }
        .navigationTitle("Customize Action")
    }
}
