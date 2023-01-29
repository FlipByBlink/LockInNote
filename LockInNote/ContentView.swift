import SwiftUI
import WidgetKit

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    @EnvironmentObject var 🛒: 🛒StoreModel
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
            🛠OptionTab()
                .tag(🔖Tab.option)
                .tabItem { Label("Option", systemImage: "gearshape") }
            ℹ️AboutAppTab()
                .tag(🔖Tab.about)
                .tabItem { Label("About App", systemImage: "questionmark") }
        }
        .animation(.default.speed(0.5), value: 🛒.🚩ADIsActive)
        .scrollDismissesKeyboard(.interactively)
        .onOpenURL { ⓤrl in
            Task {
                switch ⓤrl.description {
                    case "Rectangular": self.🔖tab = .rectangularWidget
                    case "Circular": self.🔖tab = .circularWidget
                    case "Inline": self.🔖tab = .inlineWidget
                    default: print("🐛")
                }
            }
        }
        .onChange(of: 📱.🎛rectangularData) { _ in 📱.💾saveDataAndReloadWidget() }
        .onChange(of: 📱.🎛circularData) { _ in 📱.💾saveDataAndReloadWidget() }
        .onChange(of: 📱.🎛inlineData) { _ in 📱.💾saveDataAndReloadWidget() }
    }
    enum 🔖Tab {
        case rectangularWidget, circularWidget, inlineWidget, option, about
    }
}

struct 📝RectangularWidgetTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        Self.🄲ontent($📱.🎛rectangularData)
    }
    private struct 🄲ontent: View {
        @Binding private var 🎛: 🎛RectangularDataModel
        @FocusState private var 🚩focus: Bool
        @Environment(\.scenePhase) var scenePhase
        @State private var 🚩launchedFromWidget: Bool = false
        @State private var 🚩showADMenuSheet: Bool = false
        var body: some View {
            NavigationStack {
                List {
                    self.ⓘnputField()
                    🔗URLSchemeActionButton($🎛.text)
                    if !self.🚩focus {
                        📣ADBanner(self.$🚩showADMenuSheet)
                        🛠️CustomizeFontLink($🎛)
                        🎚PlaceholderPicker($🎛.placeholder)
                    }
                }
                .modifier(📣ADMenuSheet(self.$🚩showADMenuSheet))
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
                        HStack(spacing: 12) {
                            🗑TrashButton($🎛.text)
                            📮ShareButton(🎛.text)
                            Spacer()
                            👆DoneButton { self.🚩focus = false }
                        }
                        .padding()
                    } else {
                        👆EditButton { self.🚩focus = true }
                            .padding()
                    }
                }
                .animation(.default, value: 🎛.text.isEmpty)
                .animation(.default, value: self.🚩focus)
                .background { Color(.secondarySystemBackground) }
            }
        }
        private func ⓘnputField() -> some View {
            Section {
                TextField("Input text", text: $🎛.text, axis: .vertical)
                    .font(.title3)
                    .focused(self.$🚩focus)
                    .onOpenURL { ⓤrl in
                        if ⓤrl.description == "Rectangular" {
                            self.🚩launchedFromWidget = true
                        }
                    }
                    .onChange(of: self.scenePhase) {
                        if $0 == .active {
                            if self.🚩launchedFromWidget {
                                self.🚩focus = true
                                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                self.🚩launchedFromWidget = false
                            }
                        }
                    }//Workaround: Keyboard safe area bug
            }
        }
        init(_ model: Binding<🎛RectangularDataModel>) {
            self._🎛 = model
        }
    }
}

struct 📝CircularWidgetTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        Self.🄲ontent($📱.🎛circularData)
    }
    private struct 🄲ontent: View {
        @Binding private var 🎛: 🎛CircularDataModel
        @FocusState private var 🚩focus: Bool
        @Environment(\.scenePhase) var scenePhase
        @State private var 🚩launchedFromWidget: Bool = false
        @State private var 🚩showADMenuSheet: Bool = false
        var body: some View {
            NavigationStack {
                List {
                    self.ⓘnputField()
                    🔗URLSchemeActionButton($🎛.text)
                    if !self.🚩focus {
                        📣ADBanner(self.$🚩showADMenuSheet)
                        🛠️CustomizeFontLink($🎛)
                        self.ⓑackgroundOption()
                        🎚PlaceholderPicker($🎛.placeholder)
                    }
                }
                .modifier(📣ADMenuSheet(self.$🚩showADMenuSheet))
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
                        HStack(spacing: 12) {
                            🗑TrashButton($🎛.text)
                            📮ShareButton(🎛.text)
                            Spacer()
                            👆DoneButton { self.🚩focus = false }
                        }
                        .padding()
                    } else {
                        👆EditButton { self.🚩focus = true }
                            .padding()
                    }
                }
                .animation(.default, value: 🎛.text.isEmpty)
                .animation(.default, value: self.🚩focus)
                .background { Color(.secondarySystemBackground) }
            }
        }
        private func ⓘnputField() -> some View {
            Section {
                TextField("Input text", text: $🎛.text, axis: .vertical)
                    .font(.title3)
                    .focused(self.$🚩focus)
                    .onOpenURL { ⓤrl in
                        if ⓤrl.description == "Circular" {
                            self.🚩launchedFromWidget = true
                        }
                    }
                    .onChange(of: self.scenePhase) {
                        if $0 == .active {
                            if self.🚩launchedFromWidget {
                                self.🚩focus = true
                                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                self.🚩launchedFromWidget = false
                            }
                        }
                    }//Workaround: Keyboard safe area bug
            }
        }
        private func ⓑackgroundOption() -> some View {
            Toggle(isOn: $🎛.background) {
                Label("Background",
                      systemImage: 🎛.background ? "circle.dashed.inset.filled" : "circle.dashed")
                .animation(.default, value: 🎛.background)
                .padding(.vertical, 6)
            }
        }
        init(_ model: Binding<🎛CircularDataModel>) {
            self._🎛 = model
        }
    }
}

struct 📝InlineWidgetTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    @FocusState private var 🚩focus: Bool
    @State private var 🚩showADMenuSheet: Bool = false
    var body: some View {
        NavigationStack {
            List {
                self.ⓘnputField()
                🔗URLSchemeActionButton($📱.🎛inlineData.text)
                if !self.🚩focus {
                    📣ADBanner(self.$🚩showADMenuSheet)
                    🎚PlaceholderPicker($📱.🎛inlineData.placeholder)
                }
            }
            .modifier(📣ADMenuSheet(self.$🚩showADMenuSheet))
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
                    HStack(spacing: 12) {
                        🗑TrashButton($📱.🎛inlineData.text)
                        📮ShareButton(📱.🎛inlineData.text)
                        Spacer()
                        👆DoneButton { self.🚩focus = false }
                    }
                    .padding()
                } else {
                    👆EditButton { self.🚩focus = true }
                        .padding()
                }
            }
            .animation(.default, value: 📱.🎛inlineData.text.isEmpty)
            .animation(.default, value: self.🚩focus)
            .background { Color(.secondarySystemBackground) }
        }
        .onOpenURL { ⓤrl in
            if ⓤrl.description == "Inline" {
                Task {
                    self.🚩focus = true
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                }
            }
        }
    }
    private func ⓘnputField() -> some View {
        Section {
            TextField("Input text", text: $📱.🎛inlineData.text)
                .font(.title3)
                .focused(self.$🚩focus)
        }
    }
}

struct 👆DoneButton: View {
    private var ⓐction: () -> Void
    var body: some View {
        Button {
            self.ⓐction()
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        } label: {
            Image(systemName: "checkmark")
                .foregroundColor(.white)
                .font(.largeTitle.weight(.semibold))
                .padding()
        }
        .background(Circle().foregroundColor(.accentColor))
        .shadow(radius: 3)
    }
    init(_ action: @escaping () -> Void) {
        self.ⓐction = action
    }
}

struct 👆EditButton: View {
    private var ⓐction: () -> Void
    var body: some View {
        Button {
            self.ⓐction()
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        } label: {
            Image(systemName: "pencil")
                .foregroundColor(.white)
                .font(.largeTitle.weight(.black))
                .padding()
        }
        .background {
            Circle()
                .fill(Color(white: 0.45))
        }
        .shadow(radius: 3)
    }
    init(_ action: @escaping () -> Void) {
        self.ⓐction = action
    }
}

struct 🗑TrashButton: View {
    @Binding private var ⓣext: String
    private var ⓓisable: Bool { self.ⓣext.isEmpty }
    var body: some View {
        Button {
            withAnimation {
                self.ⓣext = ""
                UINotificationFeedbackGenerator().notificationOccurred(.warning)
            }
        } label: {
            Label("Erase", systemImage: "trash")
                .foregroundColor(self.ⓓisable ? Color(white: 0.9) : .white)
                .labelStyle(.iconOnly)
                .font(.largeTitle.weight(.semibold))
                .padding()
                .shadow(radius: self.ⓓisable ? 0 : 3)
        }
        .background {
            Circle()
                .foregroundColor(self.ⓓisable ? Color(white: 0.6) : .red)
                .shadow(radius: 3)
        }
        .animation(.default, value: self.ⓓisable)
    }
    init(_ text: Binding<String>) {
        self._ⓣext = text
    }
}

struct 📮ShareButton: View {
    private var ⓣext: String
    private var ⓓisable: Bool { self.ⓣext.isEmpty }
    var body: some View {
        ShareLink(item: self.ⓣext)
            .labelStyle(.iconOnly)
            .disabled(self.ⓓisable)
            .shadow(radius: self.ⓓisable ? 0 : 3)
            .foregroundColor(self.ⓓisable ? Color(white: 0.9) : .white)
            .font(.largeTitle.weight(.semibold))
            .padding()
            .background {
                Circle()
                    .foregroundColor(self.ⓓisable ? Color(white: 0.6) : .teal)
                    .shadow(radius: 3)
            }
    }
    init(_ text: String) {
        self.ⓣext = text
    }
}

struct 🛠️CustomizeFontLink<T: 🄵ontOptions>: View {
    @Binding private var 🎛: T
    var body: some View {
        NavigationLink {
            VStack(spacing: 0) {
                GroupBox {
                    Text("""
                    This is sample.
                    これは仮の文章です。
                    이것은 플레이스 홀더입니다.
                    """)
                    .font(.system(size: CGFloat(🎛.fontSize),
                                  weight: 🎛.fontWeight.value,
                                  design: 🎛.fontDesign.value))
                    .italic(🎛.italic)
                    .foregroundStyle(🎛.level.value)
                    .multilineTextAlignment(🎛.multilineTextAlignment.value)
                }
                .padding()
                .padding(.horizontal)
                .padding(.top, 8)
                .animation(.default, value: 🎛.multilineTextAlignment)
                List {
                    Section {
                        🎚WeightPicker($🎛.fontWeight)
                        🎚DesignPicker($🎛.fontDesign)
                        🎚FontSizePicker($🎛.fontSize)
                        🎚LevelPicker($🎛.level)
                        🎚TextAlignmentPicker($🎛.multilineTextAlignment)
                        🎚ItalicPicker($🎛.italic)
                    } header: {
                        Text("Option")
                    }
                }
                .listStyle(.plain)
            }
            .navigationBarTitle("Customize font")
        } label: {
            Label("Customize Font", systemImage: "slider.horizontal.3")
                .padding(.vertical, 6)
        }
    }
    init(_ model: Binding<T>) {
        self._🎛 = model
    }
}

struct 🎚PlaceholderPicker: View {
    @Binding var ⓟlaceholder: 🄿laceholder
    var body: some View {
        Picker(selection: self.$ⓟlaceholder) {
            ForEach(🄿laceholder.allCases) { 🄿 in
                Label(🄿.rawValue, systemImage: 🄿.icon)
                    .labelStyle(.iconOnly)
            }
        } label: {
            Label("Blank icon", systemImage: "questionmark")
                .strikethrough(self.ⓟlaceholder == .nothing)
        }
    }
    init(_ ⓟlaceholder: Binding<🄿laceholder>) {
        self._ⓟlaceholder = ⓟlaceholder
    }
}

struct 🎚WeightPicker: View {
    @Binding var ⓦeight: 🅆eight
    var body: some View {
        HStack {
            🄾ptionIcon(name: "bold")
            Picker("Weight", selection: self.$ⓦeight) {
                ForEach(🅆eight.allCases) { 🅆 in
                    Text(🅆.rawValue)
                        .fontWeight(🅆.value)
                }
            }
            .pickerStyle(.navigationLink)
        }
    }
    init(_ ⓦeight: Binding<🅆eight>) {
        self._ⓦeight = ⓦeight
    }
}

struct 🎚DesignPicker: View {
    @Binding var ⓓesign: 🄳esign
    var body: some View {
        HStack {
            🄾ptionIcon(name: "a.magnify")
            Picker("Design", selection: self.$ⓓesign) {
                ForEach(🄳esign.allCases) { 🄳 in
                    Text(🄳.rawValue)
                        .font(.system(.body, design: 🄳.value))
                }
            }
            .pickerStyle(.navigationLink)
        }
    }
    init(_ ⓓesign: Binding<🄳esign>) {
        self._ⓓesign = ⓓesign
    }
}

struct 🎚FontSizePicker: View {
    @Binding var ⓢize: Int
    var body: some View {
        HStack {
            🄾ptionIcon(name: "textformat")
            Picker("Size", selection: self.$ⓢize) {
                ForEach(8..<50, id: \.self) { ⓟoint in
                    Text(ⓟoint.description)
                        .font(.system(size: CGFloat(ⓟoint)))
                }
            }
            .pickerStyle(.navigationLink)
        }
    }
    init(_ ⓢize: Binding<Int>) {
        self._ⓢize = ⓢize
    }
}

struct 🎚LevelPicker: View {
    @Binding var ⓛevel: 🄻evel
    var body: some View {
        HStack {
            🄾ptionIcon(name: "camera.filters")
                .symbolRenderingMode(.hierarchical)
            Picker("Level", selection: self.$ⓛevel) {
                ForEach(🄻evel.allCases) { 🄻 in
                    Text(🄻.rawValue)
                        .foregroundStyle(🄻.value)
                }
            }
            .pickerStyle(.navigationLink)
        }
    }
    init(_ ⓛevel: Binding<🄻evel>) {
        self._ⓛevel = ⓛevel
    }
}

struct 🎚TextAlignmentPicker: View {
    @Binding var ⓐlignment: 🄼ultilineTextAlignment
    var body: some View {
        HStack {
            🄾ptionIcon(name: "text.justify")
            Picker("Multi text alignment", selection: self.$ⓐlignment) {
                ForEach(🄼ultilineTextAlignment.allCases) { 🄼 in
                    Label(🄼.rawValue, systemImage: 🄼.icon)
                        .labelStyle(.iconOnly)
                }
            }
        }
    }
    init(_ ⓐlignment: Binding<🄼ultilineTextAlignment>) {
        self._ⓐlignment = ⓐlignment
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
    init(_ 🚩: Binding<Bool>) {
        self._🚩italic = 🚩
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

struct 📣ADBanner: View {
    @EnvironmentObject var 🛒: 🛒StoreModel
    @Binding var 🚩showADMenuSheet: Bool
    var body: some View {
        if 🛒.🚩ADIsActive {
            Section {
                📣ADView(without: .LockInNote, self.$🚩showADMenuSheet)
            }
        }
    }
    init(_ 🚩showADMenuSheet: Binding<Bool>) {
        self._🚩showADMenuSheet = 🚩showADMenuSheet
    }
}

struct 🛠OptionTab: View { // ⚙️
    var body: some View {
        NavigationStack {
            List {
                📣ADMenuLink()
                Section {
                    NavigationLink {
                        🔗URLSchemeActionSettingSection()
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
                //Section { // reject を受けて一旦 comment out
                //    Text("If lock screen widgets don't update, please close this app or switch to another app.")
                //} header: {
                //    Text("Directions")
                //}
            }
            .navigationTitle("Option")
        }
    }
    struct 🔗URLSchemeActionSettingSection: View {
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
                        Spacer()
                    }
                } header: {
                    Text("Example 2")
                } footer: {
                    Text("To search the text on DuckDuckGo.")
                }
            }
            .navigationTitle("Customize Action")
        }
    }
}

struct ℹ️AboutAppTab: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ZStack {
                        Color.clear
                        VStack(spacing: 12) {
                            Image("ClipedIcon")
                                .resizable()
                                .shadow(radius: 4, y: 1)
                                .frame(width: 100, height: 100)
                            VStack(spacing: 6) {
                                Text("LockInNote")
                                    .font(.system(.title2, design: .rounded))
                                    .fontWeight(.bold)
                                    .tracking(1.5)
                                    .opacity(0.75)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.1)
                                Text("Application for iPhone")
                                    .font(.footnote)
                                    .fontWeight(.medium)
                                    .foregroundStyle(.secondary)
                            }
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                        }
                        .padding(48)
                    }
                }
                Section {
                    Link(destination: 🔗AppStoreProductURL) {
                        HStack {
                            Label("Open AppStore page", systemImage: "link")
                            Spacer()
                            Image(systemName: "arrow.up.forward.app")
                                .imageScale(.small)
                                .foregroundStyle(.secondary)
                        }
                    }
                    NavigationLink  {
                        ℹ️AboutAppMenu()
                    } label: {
                        Label("About App", systemImage: "doc")
                    }
                }
            }
            .toolbar(.visible, for: .navigationBar)
        }
    }
}

struct 🔗URLSchemeActionButton: View {
    @AppStorage("URLSchemeLeading") var 🔗leading: String = ""
    @AppStorage("URLSchemeTrailing") var 🔗trailing: String = ""
    @AppStorage("URLSchemeButtonTitle") var 🪧buttonTitle: String = ""
    @AppStorage("EraseTextAfterAction") var 🚩eraseTextAfterAction: Bool = false
    @Environment(\.openURL) var ⓞpenURL: OpenURLAction
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
                        self.ⓞpenURL.callAsFunction(ⓤrl) { ⓐccepted in
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
    init(_ ⓠuery: Binding<String>) {
        self._ⓠuery = ⓠuery
    }
}
