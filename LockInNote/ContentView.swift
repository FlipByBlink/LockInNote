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
    @AppStorage("UnfoldSection") var 🚩unfoldSection: Bool = true
    @FocusState private var 🚩focus: Bool
    @State private var 🚩showADMenuSheet: Bool = false
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .foregroundStyle(.background)
                            .onTapGesture { self.🚩focus = true }
                            .shadow(color: .secondary, radius: 1)
                        TextField("Input text", text: $📱.🎛rectangularData.text, axis: .vertical)
                            .font(.title2)
                            .focused(self.$🚩focus)
                            .frame(height: 150)
                            .padding()
                            .toolbar {
                                🗑EraseTextButton($📱.🎛rectangularData.text)
                                ToolbarItem(placement: .keyboard) {
                                    Button {
                                        self.🚩focus = false
                                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                    } label: {
                                        Label("Done", systemImage: "keyboard.chevron.compact.down")
                                    }
                                }
                                ToolbarItem(placement: .navigationBarLeading) {
                                    ShareLink(item: 📱.🎛rectangularData.text)
                                        .disabled(📱.🎛rectangularData.text.isEmpty)
                                        .grayscale(1)
                                        .accessibilityLabel("Share")
                                }
                            }
                    }
                }
                .listRowBackground(Color.clear)
                📣ADBanner(self.$🚩showADMenuSheet)
                🔗URLSchemeActionButton($📱.🎛rectangularData.text)
                DisclosureGroup(isExpanded: self.$🚩unfoldSection) {
                    🎚WeightPicker($📱.🎛rectangularData.fontWeight)
                    🎚DesignPicker($📱.🎛rectangularData.fontDesign)
                    🎚FontSizePicker($📱.🎛rectangularData.fontSize)
                    🎚LevelPicker($📱.🎛rectangularData.level)
                    🎚TextAlignmentPicker($📱.🎛rectangularData.multilineTextAlignment)
                    🎚ItalicPicker($📱.🎛rectangularData.italic)
                    🎚PlaceholderPicker($📱.🎛rectangularData.placeholder)
                } label: {
                    Label("Customize", systemImage: "slider.horizontal.3")
                        .font(.caption)
                }
            }
            .modifier(📣ADMenuSheet(self.$🚩showADMenuSheet))
            .animation(.default, value: self.🚩unfoldSection)
            .navigationTitle("Rectangular widget")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onOpenURL { ⓤrl in
            if ⓤrl.description == "Rectangular" {
                Task {
                    self.🚩focus = true
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                }
            }
        }
    }
}

struct 📝CircularWidgetTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    @AppStorage("UnfoldSection") var 🚩unfoldSection: Bool = true
    @FocusState private var 🚩focus: Bool
    @State private var 🚩showADMenuSheet: Bool = false
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ZStack {
                        Color.clear
                        let ⓢize: CGFloat = 220
                        ZStack {
                            Circle().foregroundStyle(.background)
                                .shadow(color: .secondary, radius: 1)
                                .onTapGesture { self.🚩focus = true }
                            TextField("Input text", text: $📱.🎛circularData.text, axis: .vertical)
                                .font(.title2)
                                .focused(self.$🚩focus)
                                .frame(width: (ⓢize * 5/7) - 6, height: (ⓢize * 5/7) - 6)
                                .toolbar {
                                    🗑EraseTextButton($📱.🎛circularData.text)
                                    ToolbarItem(placement: .keyboard) {
                                        Button {
                                            self.🚩focus = false
                                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                        } label: {
                                            Label("Done", systemImage: "keyboard.chevron.compact.down")
                                        }
                                    }
                                    ToolbarItem(placement: .navigationBarLeading) {
                                        ShareLink(item: 📱.🎛circularData.text)
                                            .disabled(📱.🎛circularData.text.isEmpty)
                                            .grayscale(1)
                                            .accessibilityLabel("Share")
                                    }
                                }
                        }
                        .frame(width: ⓢize, height: ⓢize)
                    }
                    .listRowBackground(Color.clear)
                }
                📣ADBanner(self.$🚩showADMenuSheet)
                🔗URLSchemeActionButton($📱.🎛circularData.text)
                DisclosureGroup(isExpanded: self.$🚩unfoldSection) {
                    Toggle(isOn: $📱.🎛circularData.background) {
                        Label("Background",
                              systemImage: 📱.🎛circularData.background ? "circle.dashed.inset.filled" : "circle.dashed")
                        .animation(.default, value: 📱.🎛circularData.background)
                    }
                    🎚WeightPicker($📱.🎛circularData.fontWeight)
                    🎚DesignPicker($📱.🎛circularData.fontDesign)
                    🎚FontSizePicker($📱.🎛circularData.fontSize)
                    🎚LevelPicker($📱.🎛circularData.level)
                    🎚TextAlignmentPicker($📱.🎛circularData.multilineTextAlignment)
                    🎚ItalicPicker($📱.🎛circularData.italic)
                    🎚PlaceholderPicker($📱.🎛circularData.placeholder)
                } label: {
                    Label("Customize", systemImage: "slider.horizontal.3")
                        .font(.caption)
                }
            }
            .modifier(📣ADMenuSheet(self.$🚩showADMenuSheet))
            .animation(.default, value: self.🚩unfoldSection)
            .navigationTitle("Circular widget")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onOpenURL { ⓤrl in
            if ⓤrl.description == "Circular" {
                Task {
                    self.🚩focus = true
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                }
            }
        }
    }
}

struct 📝InlineWidgetTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    @AppStorage("UnfoldSection") var 🚩unfoldSection: Bool = true
    @FocusState private var 🚩focus: Bool
    @State private var 🚩showADMenuSheet: Bool = false
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Text(Date.now.formatted(.dateTime.day().weekday(.abbreviated)))
                            .font(.title2.bold())
                            .foregroundStyle(.tertiary)
                        TextField("Input text", text: $📱.🎛inlineData.text)
                            .font(.title2)
                            .focused(self.$🚩focus)
                            .textFieldStyle(.roundedBorder)
                            .submitLabel(.done)
                            .toolbar {
                                🗑EraseTextButton($📱.🎛inlineData.text)
                                ToolbarItem(placement: .navigationBarLeading) {
                                    ShareLink(item: 📱.🎛inlineData.text)
                                        .disabled(📱.🎛inlineData.text.isEmpty)
                                        .grayscale(1)
                                        .accessibilityLabel("Share")
                                }
                            }
                    }
                    .listRowBackground(Color.clear)
                }
                📣ADBanner(self.$🚩showADMenuSheet)
                🔗URLSchemeActionButton($📱.🎛inlineData.text)
                DisclosureGroup(isExpanded: self.$🚩unfoldSection) {
                    🎚PlaceholderPicker($📱.🎛inlineData.placeholder)
                } label: {
                    Label("Customize", systemImage: "slider.horizontal.3")
                        .font(.caption)
                }
            }
            .modifier(📣ADMenuSheet(self.$🚩showADMenuSheet))
            .animation(.default, value: self.🚩unfoldSection)
            .navigationTitle("Inline widget")
            .navigationBarTitleDisplayMode(.inline)
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
}

struct 🗑EraseTextButton: ToolbarContent {
    @State private var ⓞffsetX: CGFloat = 0
    @State private var 🚩eraseNow: Bool = false
    @Binding var ⓣext: String
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                UINotificationFeedbackGenerator().notificationOccurred(.warning)
                self.🚩eraseNow = true
                withAnimation {
                    self.ⓞffsetX = -32
                    self.ⓣext = ""
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    withAnimation(.default.speed(0.8)) {
                        self.🚩eraseNow = false
                        self.ⓞffsetX = 0
                    }
                }
            } label: {
                Label("Erase", systemImage: "eraser.line.dashed")
                    .opacity(self.🚩eraseNow ? 0 : 1)
            }
            .disabled(self.ⓣext.isEmpty)
            .foregroundStyle(self.ⓣext.isEmpty ? .tertiary : .secondary)
            .overlay {
                if self.🚩eraseNow {
                    Image(systemName: "eraser.line.dashed")
                        .foregroundStyle(.secondary)
                        .offset(x: self.ⓞffsetX)
                        .transition(.opacity)
                }
            }
        }
    }
    init(_ ⓣext: Binding<String>) {
        self._ⓣext = ⓣext
    }
}

struct 🎚PlaceholderPicker: View {
    @Binding var ⓟlaceholder: 🄿laceholder
    var body: some View {
        Picker(selection: self.$ⓟlaceholder) {
            ForEach(🄿laceholder.allCases) { 🄿 in
                Label(🄿.rawValue, systemImage: 🄿.icon)
            }
        } label: {
            Label("Placeholder", systemImage: "questionmark")
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
        NavigationLink {
            List {
                Picker("Weight", selection: self.$ⓦeight) {
                    ForEach(🅆eight.allCases) { 🅆 in
                        Text(🅆.rawValue)
                            .fontWeight(🅆.value)
                    }
                }
                .pickerStyle(.inline)
            }
        } label: {
            Label("Weight", systemImage: "bold")
                .fontWeight(self.ⓦeight.value)
                .badge(self.ⓦeight.rawValue)
        }
    }
    init(_ ⓦeight: Binding<🅆eight>) {
        self._ⓦeight = ⓦeight
    }
}

struct 🎚DesignPicker: View {
    @Binding var ⓓesign: 🄳esign
    var body: some View {
        NavigationLink {
            List {
                Picker("Design", selection: self.$ⓓesign) {
                    ForEach(🄳esign.allCases) { 🄳 in
                        Text(🄳.rawValue)
                            .font(.system(.title2, design: 🄳.value, weight: nil))
                            .padding(6)
                    }
                }
                .pickerStyle(.inline)
            }
        } label: {
            Label("Design", systemImage: "a.magnify")
                .font(.system(.body, design: self.ⓓesign.value, weight: nil))
                .badge(self.ⓓesign.rawValue)
        }
    }
    init(_ ⓓesign: Binding<🄳esign>) {
        self._ⓓesign = ⓓesign
    }
}

struct 🎚FontSizePicker: View {
    @Binding var ⓢize: Int
    var body: some View {
        NavigationLink {
            List {
                Picker("Size", selection: self.$ⓢize) {
                    ForEach(8..<50, id: \.self) { ⓟoint in
                        Text(ⓟoint.description)
                            .font(.system(size: CGFloat(ⓟoint)))
                    }
                }
                .pickerStyle(.inline)
            }
        } label: {
            Label("Size", systemImage: "textformat")
                .symbolRenderingMode(.hierarchical)
                .font(.system(size: CGFloat(self.ⓢize)))
                .badge(self.ⓢize.description)
        }
    }
    init(_ ⓢize: Binding<Int>) {
        self._ⓢize = ⓢize
    }
}

struct 🎚LevelPicker: View {
    @Binding var ⓛevel: 🄻evel
    var body: some View {
        NavigationLink {
            List {
                Picker("Level", selection: self.$ⓛevel) {
                    ForEach(🄻evel.allCases) { 🄻 in
                        Text(🄻.rawValue)
                            .foregroundStyle(🄻.value)
                    }
                }
                .pickerStyle(.inline)
            }
        } label: {
            Label {
                Text("Level")
                    .foregroundStyle(self.ⓛevel.value)
            } icon: {
                Image(systemName: "camera.filters")
                    .symbolRenderingMode(.hierarchical)
            }
            .badge(self.ⓛevel.rawValue)
        }
    }
    init(_ ⓛevel: Binding<🄻evel>) {
        self._ⓛevel = ⓛevel
    }
}

struct 🎚TextAlignmentPicker: View {
    @Binding var ⓐlignment: 🄼ultilineTextAlignment
    var body: some View {
        Picker(selection: self.$ⓐlignment) {
            ForEach(🄼ultilineTextAlignment.allCases) { 🄼 in
                Label(🄼.rawValue, systemImage: 🄼.icon)
            }
        } label: {
            Text("Multi\ntext\nalignment")
                .animation(.default, value: self.ⓐlignment)
                .multilineTextAlignment(self.ⓐlignment.value)
                .font(.footnote)
        }
    }
    init(_ ⓐlignment: Binding<🄼ultilineTextAlignment>) {
        self._ⓐlignment = ⓐlignment
    }
}

struct 🎚ItalicPicker: View {
    @Binding var 🚩italic: Bool
    var body: some View {
        Toggle(isOn: self.$🚩italic) {
            Label("Italic", systemImage: "italic")
                .italic(self.🚩italic)
                .animation(.default, value: self.🚩italic)
        }
    }
    init(_ 🚩: Binding<Bool>) {
        self._🚩italic = 🚩
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
