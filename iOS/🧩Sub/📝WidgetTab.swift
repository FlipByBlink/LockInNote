import SwiftUI

struct 📝RectangularWidgetTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        Self.🄲ontent($📱.widgetsModel.rectangular)
    }
    private struct 🄲ontent: View {
        @Binding private var model: 🎛RectangularWidgetModel
        @FocusState private var focus: Bool
        var body: some View {
            NavigationStack {
                List {
                    self.inputField()
                    🔗URLSchemeActionButton(self.$model.text)
                    if !self.focus {
                        🛠️CustomizeFontLink(self.$model)
                        🎚PlaceholderPicker(self.$model.placeholder)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Rectangular widget")
                            .font(.headline)
                            .opacity(self.focus ? 0.33 : 1)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .safeAreaInset(edge: .bottom) {
                    if self.focus {
                        HStack {
                            👆EraseButtonAndShareButton(self.$model.text)
                            Spacer()
                            👆DoneButton { self.focus = false }
                        }
                        .padding()
                    } else {
                        👆EditButton { self.focus = true }
                    }
                }
                .animation(.default, value: self.model.text.isEmpty)
                .animation(.default, value: self.focus)
                .modifier(👆AdjustButtonsBackground())
            }
            .modifier(📝HandleLaunchFromWidget(🔗WidgetLink.rectangular) { self.focus = true })
        }
        private func inputField() -> some View {
            Section {
                TextField("Input text", text: self.$model.text, axis: .vertical)
                    .font(.title3)
                    .focused(self.$focus)
            }
        }
        init(_ model: Binding<🎛RectangularWidgetModel>) {
            self._model = model
        }
    }
}

struct 📝CircularWidgetTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        Self.🄲ontent($📱.widgetsModel.circular)
    }
    private struct 🄲ontent: View {
        @Binding private var model: 🎛CircularWidgetModel
        @FocusState private var focus: Bool
        var body: some View {
            NavigationStack {
                List {
                    self.inputField()
                    🔗URLSchemeActionButton(self.$model.text)
                    if !self.focus {
                        🛠️CustomizeFontLink(self.$model)
                        self.backgroundOption()
                        🎚PlaceholderPicker(self.$model.placeholder)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Circular widget")
                            .font(.headline)
                            .opacity(self.focus ? 0.33 : 1)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .safeAreaInset(edge: .bottom) {
                    if self.focus {
                        HStack {
                            👆EraseButtonAndShareButton(self.$model.text)
                            Spacer()
                            👆DoneButton { self.focus = false }
                        }
                        .padding()
                    } else {
                        👆EditButton { self.focus = true }
                    }
                }
                .animation(.default, value: self.model.text.isEmpty)
                .animation(.default, value: self.focus)
                .modifier(👆AdjustButtonsBackground())
            }
            .modifier(📝HandleLaunchFromWidget(🔗WidgetLink.circular) { self.focus = true })
        }
        private func inputField() -> some View {
            Section {
                TextField("Input text", text: self.$model.text, axis: .vertical)
                    .font(.title3)
                    .focused(self.$focus)
            }
        }
        private func backgroundOption() -> some View {
            Toggle(isOn: self.$model.background) {
                Label("Background",
                      systemImage: self.model.background ? "circle.dashed.inset.filled" : "circle.dashed")
                .animation(.default, value: self.model.background)
                .padding(.vertical, 6)
            }
        }
        init(_ model: Binding<🎛CircularWidgetModel>) {
            self._model = model
        }
    }
}

struct 📝InlineWidgetTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        Self.🄲ontent($📱.widgetsModel.inline)
    }
    private struct 🄲ontent: View {
        @Binding private var model: 🎛InlineWidgetModel
        @FocusState private var focus: Bool
        var body: some View {
            NavigationStack {
                List {
                    self.inputField()
                    🔗URLSchemeActionButton(self.$model.text)
                    if !self.focus {
                        🎚PlaceholderPicker(self.$model.placeholder)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Inline widget")
                            .font(.headline)
                            .opacity(self.focus ? 0.33 : 1)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .safeAreaInset(edge: .bottom) {
                    if self.focus {
                        HStack {
                            👆EraseButtonAndShareButton(self.$model.text)
                            Spacer()
                            👆DoneButton { self.focus = false }
                        }
                        .padding()
                    } else {
                        👆EditButton { self.focus = true }
                    }
                }
                .animation(.default, value: self.model.text.isEmpty)
                .animation(.default, value: self.focus)
                .modifier(👆AdjustButtonsBackground())
            }
            .modifier(📝HandleLaunchFromWidget(🔗WidgetLink.inline) { self.focus = true })
        }
        private func inputField() -> some View {
            Section {
                TextField("Input text", text: self.$model.text)
                    .font(.title3)
                    .focused(self.$focus)
            }
        }
        init(_ model: Binding<🎛InlineWidgetModel>) {
            self._model = model
        }
    }
}

struct 📝HandleLaunchFromWidget: ViewModifier {
    @Environment(\.scenePhase) var scenePhase
    private var link: 🔗WidgetLink
    private var focusAction: () -> Void
    @State private var launchedFromWidget: Bool = false
    func body(content: Content) -> some View {
        content
            .onOpenURL {
                if $0 == self.link.url {
                    self.launchedFromWidget = true
                }
            }
            .onChange(of: self.scenePhase) {
                if $0 == .active {
                    if self.launchedFromWidget {
                        self.focusAction()
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        self.launchedFromWidget = false
                    }
                }
            }//Workaround: Keyboard safe area bug
    }
    init(_ link: 🔗WidgetLink, _ focusAction: @escaping () -> Void) {
        self.link = link
        self.focusAction = focusAction
    }
}
