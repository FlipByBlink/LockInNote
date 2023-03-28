import SwiftUI

struct 🔗URLSchemeActionButton: View {
    @AppStorage("URLSchemeLeading") var 🔗leading: String = ""
    @AppStorage("URLSchemeTrailing") var 🔗trailing: String = ""
    @AppStorage("URLSchemeButtonTitle") var 🪧buttonTitle: String = ""
    @AppStorage("EraseTextAfterAction") var 🚩eraseTextAfterAction: Bool = false
    @Environment(\.openURL) var openURL
    @Binding var ⓠuery: String
    private var ⓤrl: URL? {
        let ⓣext = self.🔗leading + self.ⓠuery + self.🔗trailing
        if let ⓔncodedText = ⓣext.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            return URL(string: ⓔncodedText)
        } else {
            return nil
        }
    }
    var body: some View {
        if !self.🔗leading.isEmpty {
            if let ⓤrl {
                Section {
                    Button {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        self.openURL(ⓤrl) { ⓐccepted in
                            if ⓐccepted && self.🚩eraseTextAfterAction {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    self.ⓠuery = ""
                                }
                            }
                        }
                    } label: {
                        Label(LocalizedStringKey(self.🪧buttonTitle.isEmpty ? "URL Scheme Action" : self.🪧buttonTitle),
                              systemImage: "command")
                        .font(.headline)
                    }
                    .disabled(self.ⓠuery.isEmpty)
                } footer: {
                    Text(ⓤrl.description)
                }
            }
        }
    }
    init(_ query: Binding<String>) {
        self._ⓠuery = query
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
    @AppStorage("URLSchemeLeading") var 🔗leading: String = ""
    @AppStorage("URLSchemeTrailing") var 🔗trailing: String = ""
    @AppStorage("URLSchemeButtonTitle") var 🪧buttonTitle: String = ""
    @AppStorage("EraseTextAfterAction") var 🚩eraseTextAfterAction: Bool = false
    private var ⓛeading: String { self.🔗leading.isEmpty ? "① + " : self.🔗leading }
    private var ⓣrailing: String { self.🔗trailing.isEmpty ? " + ②" : self.🔗trailing }
    var body: some View {
        List {
            Section {
                VStack {
                    HStack {
                        if self.🔗leading.isEmpty {
                            Text("① +")
                                .foregroundStyle(.secondary)
                        }
                        Text(self.🔗leading + "TEXT" + self.🔗trailing)
                            .italic()
                            .font(.system(.subheadline, design: .monospaced))
                            .multilineTextAlignment(.center)
                            .padding(8)
                            .frame(minHeight: 100)
                        if self.🔗trailing.isEmpty {
                            Text("+ ②")
                                .foregroundStyle(.secondary)
                        }
                    }
                    TextField("① URL scheme", text: self.$🔗leading)
                    TextField("② Trailing component", text: self.$🔗trailing)
                        .font(.subheadline)
                        .padding(.bottom, 4)
                }
                .textFieldStyle(.roundedBorder)
            } header: {
                Text("URL scheme")
            }
            Section {
                TextField("Input text of button", text: self.$🪧buttonTitle)
                    .textFieldStyle(.roundedBorder)
            } header: {
                Text("Button label")
            }
            Section {
                Toggle(isOn: self.$🚩eraseTextAfterAction) {
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
            Image("URLSchemeActionExample")
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
