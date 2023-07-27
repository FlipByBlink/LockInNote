import SwiftUI
import WidgetKit

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    @EnvironmentObject var 🛒: 🛒InAppPurchaseModel
    @Environment(\.scenePhase) var scenePhase
    @State private var tab: 🔖Tab = .rectangularWidget
    var body: some View {
        TabView(selection: self.$tab) {
            📝RectangularWidgetTab()
                .tag(🔖Tab.rectangularWidget)
                .tabItem { Label("Rectangular", systemImage: "rectangle.dashed") }
            📝CircularWidgetTab()
                .tag(🔖Tab.circularWidget)
                .tabItem { Label("Circular", systemImage: "circle.dashed") }
            📝InlineWidgetTab()
                .tag(🔖Tab.inlineWidget)
                .tabItem { Label("Inline", systemImage: "rectangle.and.pencil.and.ellipsis") }
            💁WidgetGuideTab()
                .tag(🔖Tab.guide)
                .tabItem { Label("Guide", systemImage: "questionmark") }
            🛠MenuTab()
                .tag(🔖Tab.menu)
                .tabItem { Label("Menu", systemImage: "gearshape") }
        }
        .scrollDismissesKeyboard(.interactively)
        .modifier(💬RequestUserReview())
//        .modifier(📣ADSheet())
        .onSubmit { 📱.widgetsModel.saveData_reloadWidget_updateWCContext() }
        .onChange(of: self.scenePhase) {
            if $0 == .background { 📱.widgetsModel.saveData_reloadWidget_updateWCContext() }
        }
        .onOpenURL { self.tab.handleURL($0) }
    }
}

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
                .modifier(🄰djustButtonsBackground())
            }
            .modifier(🄷andleLaunchFromWidget(🔗WidgetLink.rectangular) { self.focus = true })
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
                .modifier(🄰djustButtonsBackground())
            }
            .modifier(🄷andleLaunchFromWidget(🔗WidgetLink.circular) { self.focus = true })
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
                .modifier(🄰djustButtonsBackground())
            }
            .modifier(🄷andleLaunchFromWidget(🔗WidgetLink.inline) { self.focus = true })
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

struct 🄷andleLaunchFromWidget: ViewModifier {
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

struct 👆EditButton: View { // 🖊️
    private var focusAction: () -> Void
    var body: some View {
        Button {
            self.focusAction()
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        } label: {
            Image(systemName: "pencil")
                .foregroundColor(.white)
                .font(.largeTitle.weight(.black))
                .padding()
        }
        .background {
            Circle()
                .foregroundColor(.accentColor)
        }
        .shadow(radius: 3)
        .padding()
    }
    init(_ focusAction: @escaping () -> Void) {
        self.focusAction = focusAction
    }
}

struct 👆DoneButton: View { // ☑️
    @EnvironmentObject var 📱: 📱AppModel
    //@EnvironmentObject var 🛒: 🛒InAppPurchaseModel
    private var unfocusAction: () -> Void
    var body: some View {
        Button {
            self.unfocusAction()
            📱.widgetsModel.saveData_reloadWidget_updateWCContext()
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            Task { @MainActor in
                try await Task.sleep(for: .seconds(0.45))
                //if 🛒.checkToShowADSheet() { self.showAD = true }
            }
        } label: {
            Label("Done", systemImage: "checkmark")
                .labelStyle(.iconOnly)
                .foregroundColor(.white)
                .font(.largeTitle.weight(.bold))
                .padding()
        }
        .background(Circle().foregroundColor(.accentColor))
        .shadow(radius: 3)
    }
    init(_ unfocusAction: @escaping () -> Void) {
        self.unfocusAction = unfocusAction
    }
}

struct 👆EraseButtonAndShareButton: View { // 🗑 📤
    @Binding private var text: String
    private var disable: Bool { self.text.isEmpty }
    @Environment(\.colorScheme) var colorScheme
    private var iconColor: Color {
        if self.disable {
            switch self.colorScheme {
                case .light: Color(white: 0.9)
                case .dark: Color(white: 0.6)
                @unknown default: Color(white: 0.9)
            }
        } else {
            .white
        }
    }
    private func backgroundColor(_ ⓒolor: Color) -> Color {
        if self.disable {
            switch self.colorScheme {
                case .light: Color(white: 0.6)
                case .dark: Color(white: 0.3)
                @unknown default: Color(white: 0.6)
            }
        } else {
            ⓒolor
        }
    }
    var body: some View {
        HStack(spacing: 12) {
            Button {
                withAnimation {
                    self.text = ""
                    UINotificationFeedbackGenerator().notificationOccurred(.warning)
                }
            } label: {
                Label("Erase", systemImage: "trash")
                    .foregroundColor(self.iconColor)
                    .labelStyle(.iconOnly)
                    .font(.largeTitle.weight(.semibold))
                    .padding()
                    .shadow(radius: self.disable ? 0 : 3)
            }
            .disabled(self.disable)
            .background {
                Circle()
                    .foregroundColor(self.backgroundColor(.red))
                    .shadow(radius: 3)
            }
            .animation(.default, value: self.disable)
            ShareLink(item: self.text)
                .labelStyle(.iconOnly)
                .disabled(self.disable)
                .shadow(radius: self.disable ? 0 : 3)
                .foregroundColor(self.iconColor)
                .font(.largeTitle.weight(.semibold))
                .padding()
                .background {
                    Circle()
                        .foregroundColor(self.backgroundColor(.teal))
                        .shadow(radius: 3)
                }
        }
    }
    init(_ text: Binding<String>) {
        self._text = text
    }
}

struct 🄰djustButtonsBackground: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        content
            .background {
                if self.colorScheme == .light {
                    Color(.secondarySystemBackground)
                }
            }
    }
}

struct 🛠️CustomizeFontLink<T: 🄵ontOptions>: View {
    @Binding private var fontOptions: T
    var body: some View {
        NavigationLink {
            VStack(spacing: 0) {
                GroupBox {
                    Text(verbatim: """
                        This is sample.
                        これは仮の文章です。
                        이것은 플레이스 홀더입니다.
                        """)
                    .font(.system(size: CGFloat(self.fontOptions.fontSize),
                                  weight: self.fontOptions.fontWeight.value,
                                  design: self.fontOptions.fontDesign.value))
                    .italic(self.fontOptions.italic)
                    .foregroundStyle(self.fontOptions.level.value)
                    .multilineTextAlignment(self.fontOptions.multilineTextAlignment.value)
                }
                .padding()
                .padding(.horizontal)
                .padding(.top, 8)
                .animation(.default, value: self.fontOptions.multilineTextAlignment)
                List {
                    Section {
                        🎚WeightPicker(self.$fontOptions.fontWeight)
                        🎚DesignPicker(self.$fontOptions.fontDesign)
                        🎚FontSizePicker(self.$fontOptions.fontSize)
                        🎚LevelPicker(self.$fontOptions.level)
                        🎚TextAlignmentPicker(self.$fontOptions.multilineTextAlignment)
                        🎚ItalicPicker(self.$fontOptions.italic)
                    } header: {
                        Text("Option")
                    }
                }
                .listStyle(.plain)
            }
            .navigationBarTitle("Customize font")
        } label: {
            Label("Customize font", systemImage: "slider.horizontal.3")
                .padding(.vertical, 6)
        }
    }
    init(_ fontOptions: Binding<T>) {
        self._fontOptions = fontOptions
    }
}

struct 🎚PlaceholderPicker: View {//Blank icon
    @Binding var placeholder: 🄿laceholder
    var body: some View {
        Picker(selection: self.$placeholder) {
            ForEach(🄿laceholder.allCases) { ⓒase in
                Label(LocalizedStringKey(ⓒase.rawValue), systemImage: ⓒase.icon)
                    .labelStyle(.iconOnly)
            }
        } label: {
            Label("Blank icon", systemImage: "questionmark")
                .strikethrough(self.placeholder == .nothing)
        }
    }
    init(_ placeholder: Binding<🄿laceholder>) {
        self._placeholder = placeholder
    }
}

struct 🎚WeightPicker: View {
    @Binding var value: 🅆eight
    var body: some View {
        HStack {
            🄾ptionIcon(name: "bold")
            Picker("Weight", selection: self.$value) {
                ForEach(🅆eight.allCases) { ⓒase in
                    Text(LocalizedStringKey(ⓒase.rawValue))
                        .fontWeight(ⓒase.value)
                }
            }
            .pickerStyle(.navigationLink)
        }
    }
    init(_ value: Binding<🅆eight>) {
        self._value = value
    }
}

struct 🎚DesignPicker: View {
    @Binding var value: 🄳esign
    var body: some View {
        HStack {
            🄾ptionIcon(name: "a.magnify")
            Picker("Design", selection: self.$value) {
                ForEach(🄳esign.allCases) { ⓒase in
                    Text(LocalizedStringKey(ⓒase.rawValue))
                        .font(.system(.body, design: ⓒase.value))
                }
            }
            .pickerStyle(.navigationLink)
        }
    }
    init(_ value: Binding<🄳esign>) {
        self._value = value
    }
}

struct 🎚FontSizePicker: View {
    @Binding var value: Int
    var body: some View {
        HStack {
            🄾ptionIcon(name: "textformat")
            Picker("Size", selection: self.$value) {
                ForEach(8 ..< 50, id: \.self) { ⓟoint in
                    Text(ⓟoint.description)
                        .font(.system(size: CGFloat(ⓟoint)))
                }
            }
            .pickerStyle(.navigationLink)
        }
    }
    init(_ value: Binding<Int>) {
        self._value = value
    }
}

struct 🎚LevelPicker: View {
    @Binding var value: 🄻evel
    var body: some View {
        HStack {
            🄾ptionIcon(name: "camera.filters")
                .symbolRenderingMode(.hierarchical)
            Picker("Level", selection: self.$value) {
                ForEach(🄻evel.allCases) { ⓒase in
                    Text(LocalizedStringKey(ⓒase.rawValue))
                        .foregroundStyle(ⓒase.value)
                }
            }
            .pickerStyle(.navigationLink)
        }
    }
    init(_ value: Binding<🄻evel>) {
        self._value = value
    }
}

struct 🎚TextAlignmentPicker: View {
    @Binding var value: 🄼ultilineTextAlignment
    var body: some View {
        HStack {
            🄾ptionIcon(name: "text.justify")
            Picker("Multi text alignment", selection: self.$value) {
                ForEach(🄼ultilineTextAlignment.allCases) { ⓒase in
                    Label(LocalizedStringKey(ⓒase.rawValue), systemImage: ⓒase.icon)
                        .labelStyle(.iconOnly)
                }
            }
        }
    }
    init(_ value: Binding<🄼ultilineTextAlignment>) {
        self._value = value
    }
}

struct 🎚ItalicPicker: View {
    @Binding var value: Bool
    var body: some View {
        HStack {
            🄾ptionIcon(name: "italic")
            Toggle(isOn: self.$value) {
                Text("Italic")
            }
        }
    }
    init(_ value: Binding<Bool>) {
        self._value = value
    }
}

struct 🄾ptionIcon: View {
    var name: String
    var body: some View {
        Image(systemName: self.name)
            .resizable()
            .scaledToFit()
            .frame(width: 16, height: 16)
            .padding(.horizontal, 10)
            .foregroundColor(.accentColor)
    }
}
