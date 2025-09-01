import SwiftUI

struct 📝NoteTab: View {
    @EnvironmentObject var app: 📱AppModel
    @EnvironmentObject var note: 📝NoteModel
    @Environment(\.colorScheme) var colorScheme
    @FocusState var focus: Bool
    var body: some View {
        NavigationStack {
            ZStack {
                self.backgroundColor()
                List {
                    Section {
                        TextField("Input text",
                                  text: self.$note.text,
                                  axis: .vertical)
                        .font(.title3)
                        .padding(.vertical, 8)
                        .onChange(of: self.note.text) { self.note.save(.text, $1) }
                        .focused(self.$focus)
                        .onChange(of: self.app.preferTextFieldFocus) {
                            if $1 == self.note.family { self.app.handle(&self.focus) }
                        }
                    }
                    self.urlSchemeActionButton()
                }
                .frame(maxWidth: 650)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(self.$note.title)
            .onChange(of: self.note.title) { self.note.save(.title, $1) }
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
            .toolbar { self.customizeButton() }
            .animation(.default, value: self.note.text.isEmpty)
            .animation(.default, value: self.focus)
        }
#if os(iOS)
        .scrollDismissesKeyboard(.interactively)
#endif
        .tag(🔖Tab.note(self.note.family))
        .tabItem { Label(self.note.title, systemImage: "note.text") }
    }
}

private extension 📝NoteTab {
    @ViewBuilder
    private func backgroundColor() -> some View {
        if self.colorScheme == .light {
            Color(uiColor: .secondarySystemBackground)
                .ignoresSafeArea()
        }
    }
    private func urlSchemeActionButton() -> some View {
#if os(iOS)
        🔗URLSchemeActionButton(self.$note.text)
#elseif os(visionOS)
        EmptyView()
#endif
    }
    private func customizeButton() -> some View {
        Button {
            self.focus = false
            self.app.sheet = .customize(self.note.family)
            💥Feedback.selection()
        } label: {
            Label("Customize \"\(self.note.title)\"",
                  systemImage: "slider.horizontal.3")
        }
        .grayscale(self.focus ? 1 : 0) //iOS17では変化しない
    }
}
