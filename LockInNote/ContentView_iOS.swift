import SwiftUI
import WidgetKit

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    @EnvironmentObject var 🛒: 🛒StoreModel
    @Environment(\.scenePhase) var scenePhase
    @State private var 🔖tab: 🔖Tab = .rectangularWidget
    var body: some View {
        TabView(selection: self.$🔖tab) {
            📝RectangularWidgetTab()
                .tag(🔖Tab.rectangularWidget)
                .tabItem { Label("Rectangular", systemImage: "rectangle.dashed") }
            📝CircularWidgetTab()
                .tag(🔖Tab.circularWidget)
                .tabItem { Label("Circular", systemImage: "circle.dashed") }
            📝InlineWidgetTab()
                .tag(🔖Tab.inlineWidget)
                .tabItem { Label("Inline", systemImage: "rectangle.and.pencil.and.ellipsis") }
            🛠MenuTab()
                .tag(🔖Tab.menu)
                .tabItem { Label("Menu", systemImage: "gearshape") }
        }
        .scrollDismissesKeyboard(.interactively)
        .modifier(💬RequestUserReview(self.$🔖tab))
        .onSubmit { 📱.saveAndReloadWidgetAndUpdateWCContext() }
        .onChange(of: self.scenePhase) { [scenePhase] ⓝewValue in
            if scenePhase == .active, ⓝewValue == .inactive {
                📱.saveAndReloadWidgetAndUpdateWCContext()
            }
        }
        .onOpenURL { ⓤrl in
            switch ⓤrl.description {
                case "Rectangular": self.🔖tab = .rectangularWidget
                case "Circular": self.🔖tab = .circularWidget
                case "Inline": self.🔖tab = .inlineWidget
                default: print("🐛")
            }
        }
    }
}

enum 🔖Tab {
    case rectangularWidget, circularWidget, inlineWidget, menu
}

struct 📝RectangularWidgetTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        Self.🄲ontent($📱.widgetsModel.rectangular)
    }
    private struct 🄲ontent: View {
        @Binding private var ⓜodel: 🎛RectangularWidgetModel
        @FocusState private var 🚩focus: Bool
        var body: some View {
            NavigationStack {
                List {
                    self.ⓘnputField()
                    🔗URLSchemeActionButton(self.$ⓜodel.text)
                    if !self.🚩focus {
                        🛠️CustomizeFontLink(self.$ⓜodel)
                        🎚PlaceholderPicker(self.$ⓜodel.placeholder)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Rectangular widget")
                            .font(.headline)
                            .opacity(self.🚩focus ? 0.33 : 1)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .safeAreaInset(edge: .bottom) {
                    if self.🚩focus {
                        HStack {
                            👆EraseButtonAndShareButton(self.$ⓜodel.text)
                            Spacer()
                            👆DoneButton { self.🚩focus = false }
                        }
                        .padding()
                    } else {
                        👆EditButton { self.🚩focus = true }
                    }
                }
                .animation(.default, value: self.ⓜodel.text.isEmpty)
                .animation(.default, value: self.🚩focus)
                .modifier(🄰djustButtonsBackground())
            }
            .modifier(🄷andleLaunchFromWidget("Rectangular") { self.🚩focus = true })
        }
        private func ⓘnputField() -> some View {
            Section {
                TextField("Input text", text: self.$ⓜodel.text, axis: .vertical)
                    .font(.title3)
                    .focused(self.$🚩focus)
            }
        }
        init(_ model: Binding<🎛RectangularWidgetModel>) {
            self._ⓜodel = model
        }
    }
}

struct 📝CircularWidgetTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        Self.🄲ontent($📱.widgetsModel.circular)
    }
    private struct 🄲ontent: View {
        @Binding private var ⓜodel: 🎛CircularWidgetModel
        @FocusState private var 🚩focus: Bool
        var body: some View {
            NavigationStack {
                List {
                    self.ⓘnputField()
                    🔗URLSchemeActionButton(self.$ⓜodel.text)
                    if !self.🚩focus {
                        🛠️CustomizeFontLink(self.$ⓜodel)
                        self.ⓑackgroundOption()
                        🎚PlaceholderPicker(self.$ⓜodel.placeholder)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Circular widget")
                            .font(.headline)
                            .opacity(self.🚩focus ? 0.33 : 1)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .safeAreaInset(edge: .bottom) {
                    if self.🚩focus {
                        HStack {
                            👆EraseButtonAndShareButton(self.$ⓜodel.text)
                            Spacer()
                            👆DoneButton { self.🚩focus = false }
                        }
                        .padding()
                    } else {
                        👆EditButton { self.🚩focus = true }
                    }
                }
                .animation(.default, value: self.ⓜodel.text.isEmpty)
                .animation(.default, value: self.🚩focus)
                .modifier(🄰djustButtonsBackground())
            }
            .modifier(🄷andleLaunchFromWidget("Circular") { self.🚩focus = true })
        }
        private func ⓘnputField() -> some View {
            Section {
                TextField("Input text", text: self.$ⓜodel.text, axis: .vertical)
                    .font(.title3)
                    .focused(self.$🚩focus)
            }
        }
        private func ⓑackgroundOption() -> some View {
            Toggle(isOn: self.$ⓜodel.background) {
                Label("Background",
                      systemImage: self.ⓜodel.background ? "circle.dashed.inset.filled" : "circle.dashed")
                .animation(.default, value: self.ⓜodel.background)
                .padding(.vertical, 6)
            }
        }
        init(_ model: Binding<🎛CircularWidgetModel>) {
            self._ⓜodel = model
        }
    }
}

struct 📝InlineWidgetTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        Self.🄲ontent($📱.widgetsModel.inline)
    }
    private struct 🄲ontent: View {
        @Binding private var ⓜodel: 🎛InlineWidgetModel
        @FocusState private var 🚩focus: Bool
        var body: some View {
            NavigationStack {
                List {
                    self.ⓘnputField()
                    🔗URLSchemeActionButton(self.$ⓜodel.text)
                    if !self.🚩focus {
                        🎚PlaceholderPicker(self.$ⓜodel.placeholder)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Inline widget")
                            .font(.headline)
                            .opacity(self.🚩focus ? 0.33 : 1)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .safeAreaInset(edge: .bottom) {
                    if self.🚩focus {
                        HStack {
                            👆EraseButtonAndShareButton(self.$ⓜodel.text)
                            Spacer()
                            👆DoneButton { self.🚩focus = false }
                        }
                        .padding()
                    } else {
                        👆EditButton { self.🚩focus = true }
                    }
                }
                .animation(.default, value: self.ⓜodel.text.isEmpty)
                .animation(.default, value: self.🚩focus)
                .modifier(🄰djustButtonsBackground())
            }
            .modifier(🄷andleLaunchFromWidget("Inline") { self.🚩focus = true })
        }
        private func ⓘnputField() -> some View {
            Section {
                TextField("Input text", text: self.$ⓜodel.text)
                    .font(.title3)
                    .focused(self.$🚩focus)
            }
        }
        init(_ model: Binding<🎛InlineWidgetModel>) {
            self._ⓜodel = model
        }
    }
}

struct 🄷andleLaunchFromWidget: ViewModifier {
    @Environment(\.scenePhase) var scenePhase
    private var ⓘd: String
    private var ⓕocusAction: () -> Void
    @State private var 🚩launchedFromWidget: Bool = false
    func body(content: Content) -> some View {
        content
            .onOpenURL { ⓤrl in
                if ⓤrl.description == self.ⓘd {
                    self.🚩launchedFromWidget = true
                }
            }
            .onChange(of: self.scenePhase) {
                if $0 == .active {
                    if self.🚩launchedFromWidget {
                        self.ⓕocusAction()
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        self.🚩launchedFromWidget = false
                    }
                }
            }//Workaround: Keyboard safe area bug
    }
    init(_ id: String, _ focusAction: @escaping () -> Void) {
        self.ⓘd = id
        self.ⓕocusAction = focusAction
    }
}

struct 👆EditButton: View { // 🖊️
    private var ⓕocusAction: () -> Void
    var body: some View {
        Button {
            self.ⓕocusAction()
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
        self.ⓕocusAction = focusAction
    }
}

struct 👆DoneButton: View { // ☑️
    @EnvironmentObject var 🛒: 🛒StoreModel
    private var ⓤnfocusAction: () -> Void
    var body: some View {
        Button {
            self.ⓤnfocusAction()
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            Task { @MainActor in
                try await Task.sleep(for: .seconds(0.45))
                🛒.checkToShowADSheet()
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
        self.ⓤnfocusAction = unfocusAction
    }
}

struct 👆EraseButtonAndShareButton: View { // 🗑 📤
    @Binding private var ⓣext: String
    private var ⓓisable: Bool { self.ⓣext.isEmpty }
    @Environment(\.colorScheme) var colorScheme
    private var ⓘconColor: Color {
        if self.ⓓisable {
            switch self.colorScheme {
                case .light: return Color(white: 0.9)
                case .dark: return Color(white: 0.6)
                @unknown default: return Color(white: 0.9)
            }
        } else {
            return .white
        }
    }
    private func ⓑackgroundColor(_ ⓒolor: Color) -> Color {
        if self.ⓓisable {
            switch self.colorScheme {
                case .light: return Color(white: 0.6)
                case .dark: return Color(white: 0.4)
                @unknown default: return Color(white: 0.6)
            }
        } else {
            return ⓒolor
        }
    }
    var body: some View {
        HStack(spacing: 12) {
            Button {
                withAnimation {
                    self.ⓣext = ""
                    UINotificationFeedbackGenerator().notificationOccurred(.warning)
                }
            } label: {
                Label("Erase", systemImage: "trash")
                    .foregroundColor(self.ⓘconColor)
                    .labelStyle(.iconOnly)
                    .font(.largeTitle.weight(.semibold))
                    .padding()
                    .shadow(radius: self.ⓓisable ? 0 : 3)
            }
            .disabled(self.ⓓisable)
            .background {
                Circle()
                    .foregroundColor(self.ⓑackgroundColor(.red))
                    .shadow(radius: 3)
            }
            .animation(.default, value: self.ⓓisable)
            ShareLink(item: self.ⓣext)
                .labelStyle(.iconOnly)
                .disabled(self.ⓓisable)
                .shadow(radius: self.ⓓisable ? 0 : 3)
                .foregroundColor(self.ⓘconColor)
                .font(.largeTitle.weight(.semibold))
                .padding()
                .background {
                    Circle()
                        .foregroundColor(self.ⓑackgroundColor(.teal))
                        .shadow(radius: 3)
                }
        }
    }
    init(_ text: Binding<String>) {
        self._ⓣext = text
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
    @Binding private var ⓕontOptions: T
    var body: some View {
        NavigationLink {
            VStack(spacing: 0) {
                GroupBox {
                    Text("""
                    This is sample.
                    これは仮の文章です。
                    이것은 플레이스 홀더입니다.
                    """)
                    .font(.system(size: CGFloat(self.ⓕontOptions.fontSize),
                                  weight: self.ⓕontOptions.fontWeight.value,
                                  design: self.ⓕontOptions.fontDesign.value))
                    .italic(self.ⓕontOptions.italic)
                    .foregroundStyle(self.ⓕontOptions.level.value)
                    .multilineTextAlignment(self.ⓕontOptions.multilineTextAlignment.value)
                }
                .padding()
                .padding(.horizontal)
                .padding(.top, 8)
                .animation(.default, value: self.ⓕontOptions.multilineTextAlignment)
                List {
                    Section {
                        🎚WeightPicker(self.$ⓕontOptions.fontWeight)
                        🎚DesignPicker(self.$ⓕontOptions.fontDesign)
                        🎚FontSizePicker(self.$ⓕontOptions.fontSize)
                        🎚LevelPicker(self.$ⓕontOptions.level)
                        🎚TextAlignmentPicker(self.$ⓕontOptions.multilineTextAlignment)
                        🎚ItalicPicker(self.$ⓕontOptions.italic)
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
        self._ⓕontOptions = fontOptions
    }
}

struct 🎚PlaceholderPicker: View {//Blank icon
    @Binding var ⓟlaceholder: 🄿laceholder
    var body: some View {
        Picker(selection: self.$ⓟlaceholder) {
            ForEach(🄿laceholder.allCases) { ⓒase in
                Label(LocalizedStringKey(ⓒase.rawValue), systemImage: ⓒase.icon)
                    .labelStyle(.iconOnly)
            }
        } label: {
            Label("Blank icon", systemImage: "questionmark")
                .strikethrough(self.ⓟlaceholder == .nothing)
        }
    }
    init(_ placeholder: Binding<🄿laceholder>) {
        self._ⓟlaceholder = placeholder
    }
}

struct 🎚WeightPicker: View {
    @Binding var ⓦeight: 🅆eight
    var body: some View {
        HStack {
            🄾ptionIcon(name: "bold")
            Picker("Weight", selection: self.$ⓦeight) {
                ForEach(🅆eight.allCases) { ⓒase in
                    Text(LocalizedStringKey(ⓒase.rawValue))
                        .fontWeight(ⓒase.value)
                }
            }
            .pickerStyle(.navigationLink)
        }
    }
    init(_ weight: Binding<🅆eight>) {
        self._ⓦeight = weight
    }
}

struct 🎚DesignPicker: View {
    @Binding var ⓓesign: 🄳esign
    var body: some View {
        HStack {
            🄾ptionIcon(name: "a.magnify")
            Picker("Design", selection: self.$ⓓesign) {
                ForEach(🄳esign.allCases) { ⓒase in
                    Text(LocalizedStringKey(ⓒase.rawValue))
                        .font(.system(.body, design: ⓒase.value))
                }
            }
            .pickerStyle(.navigationLink)
        }
    }
    init(_ design: Binding<🄳esign>) {
        self._ⓓesign = design
    }
}

struct 🎚FontSizePicker: View {
    @Binding var ⓢize: Int
    var body: some View {
        HStack {
            🄾ptionIcon(name: "textformat")
            Picker("Size", selection: self.$ⓢize) {
                ForEach(8 ..< 50, id: \.self) { ⓟoint in
                    Text(ⓟoint.description)
                        .font(.system(size: CGFloat(ⓟoint)))
                }
            }
            .pickerStyle(.navigationLink)
        }
    }
    init(_ size: Binding<Int>) {
        self._ⓢize = size
    }
}

struct 🎚LevelPicker: View {
    @Binding var ⓛevel: 🄻evel
    var body: some View {
        HStack {
            🄾ptionIcon(name: "camera.filters")
                .symbolRenderingMode(.hierarchical)
            Picker("Level", selection: self.$ⓛevel) {
                ForEach(🄻evel.allCases) { ⓒase in
                    Text(LocalizedStringKey(ⓒase.rawValue))
                        .foregroundStyle(ⓒase.value)
                }
            }
            .pickerStyle(.navigationLink)
        }
    }
    init(_ level: Binding<🄻evel>) {
        self._ⓛevel = level
    }
}

struct 🎚TextAlignmentPicker: View {
    @Binding var ⓐlignment: 🄼ultilineTextAlignment
    var body: some View {
        HStack {
            🄾ptionIcon(name: "text.justify")
            Picker("Multi text alignment", selection: self.$ⓐlignment) {
                ForEach(🄼ultilineTextAlignment.allCases) { ⓒase in
                    Label(LocalizedStringKey(ⓒase.rawValue), systemImage: ⓒase.icon)
                        .labelStyle(.iconOnly)
                }
            }
        }
    }
    init(_ alignment: Binding<🄼ultilineTextAlignment>) {
        self._ⓐlignment = alignment
    }
}

struct 🎚ItalicPicker: View {
    @Binding var 🚩italic: Bool
    var body: some View {
        HStack {
            🄾ptionIcon(name: "italic")
            Toggle(isOn: self.$🚩italic) {
                Text("Italic")
            }
        }
    }
    init(_ italic: Binding<Bool>) {
        self._🚩italic = italic
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
