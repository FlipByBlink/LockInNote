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
                        .padding(.vertical, 8)
                        .focused(self.$focus)
                        .onChange(of: self.app.preferTextFieldFocus) {
                            guard $0 == self.note.family else { return }
                            self.focus = true
                            self.app.completeFocusHandle()
                        }
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
        .tag(🔖Tab.note(self.note.family))
        .tabItem { Label(self.note.title, systemImage: "note.text") }
    }
}
