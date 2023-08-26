import SwiftUI

struct 📝NoteTab: View {
    @EnvironmentObject var app: 📱AppModel
    @EnvironmentObject var note: 📝NoteModel
    @Environment(\.colorScheme) var colorScheme
    @FocusState var focus: Bool
    var body: some View {
        NavigationStack {
            ZStack {
                if self.colorScheme == .light {
                    Color(uiColor: .secondarySystemBackground)
                        .ignoresSafeArea()
                }
                List {
                    Section {
                        TextField("Input text",
                                  text: self.$note.text,
                                  axis: .vertical)
                        .font(.title3)
                        .focused(self.$focus)
                        .padding(.vertical, 8)
                    }
                    🔗URLSchemeActionButton(self.$note.text)
                }
                .frame(maxWidth: 650)
            }
            .navigationTitle(self.$note.title)
            .navigationBarTitleDisplayMode(.inline)
            .safeAreaInset(edge: .bottom) {
                if self.focus {
                    HStack {
                        👆EraseButtonAndShareButton()
                        Spacer()
                        👆DoneButton { self.focus = false }
                    }
                    .padding()
                } else {
                    👆EditButton { self.focus = true }
                }
            }
            .toolbar {
                Button {
                    self.focus = false
                    self.app.sheet = .customize(self.note.family)
                } label: {
                    Label("Customize \"\(self.note.title)\"",
                          systemImage: "slider.horizontal.3")
                }
                .grayscale(self.focus ? 1 : 0) //TODO: iOS17betaでは変化しない。要チェック
            }
            .animation(.default, value: self.note.text.isEmpty)
            .animation(.default, value: self.focus)
        }
        .scrollDismissesKeyboard(.interactively)
        .onChange(of: self.note.text) { self.note.save(.text, $0) }
        .onChange(of: self.note.title) { self.note.save(.title, $0) }
        .onOpenURL(perform: self.handleFocus(_:))
        .tag(🔖Tab.note(self.note.family))
        .tabItem { Label(self.note.title, systemImage: "note.text") }
    }
    private func handleFocus(_ ⓤrl: URL) {
        do {
            try self.app.handleTab(self.note.family, ⓤrl)
            Task {
                guard !UserDefaults.standard.bool(forKey: "preventAutomaticKeyboard") else { return }
                try? await Task.sleep(for: .seconds(0.25))
                self.focus = true
            }
        } catch {
            switch error as? 📱AppModel.HandleError {
                case .customizing, .notTarget, .presentedSheet: break
                case .urlDecodeFailed, .none: assertionFailure()
            }
        }
    }
}
