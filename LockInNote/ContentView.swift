
import SwiftUI
import WidgetKit

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    @EnvironmentObject var 🛒: 🛒StoreModel
    @State private var 🔖Tab: 🔖TabTag = .rectangularWidget
    var body: some View {
        TabView(selection: $🔖Tab) {
            📝RectangularWidgetTab()
                .tag(🔖TabTag.rectangularWidget)
                .tabItem { Label("Rectangular", systemImage: "rectangle.dashed") }
            📝CircularWidgetTab()
                .tag(🔖TabTag.circularWidget)
                .tabItem { Label("Circular", systemImage: "circle.dashed") }
            📝InlineWidgetTab()
                .tag(🔖TabTag.inlineWidget)
                .tabItem { Label("Inline", systemImage: "rectangle.and.pencil.and.ellipsis") }
            🛠OptionTab()
                .tag(🔖TabTag.option)
                .tabItem { Label("Option", systemImage: "gearshape") }
            ℹ️AboutAppTab()
                .tag(🔖TabTag.about)
                .tabItem { Label("About App", systemImage: "questionmark") }
        }
        .animation(.default.speed(0.5), value: 🛒.🚩ADIsActive)
        .scrollDismissesKeyboard(.interactively)
        .onOpenURL { 🔗 in
            DispatchQueue.main.async {
                switch 🔗.description {
                    case "Rectangular": 🔖Tab = .rectangularWidget
                    case "Circular": 🔖Tab = .circularWidget
                    case "Inline": 🔖Tab = .inlineWidget
                    default: print("🐛")
                }
            }
        }
        .onChange(of: 📱.🎛RectangularData) { _ in 📱.💾SaveDataAndReloadWidget() }
        .onChange(of: 📱.🎛CircularData) { _ in 📱.💾SaveDataAndReloadWidget() }
        .onChange(of: 📱.🎛InlineData) { _ in 📱.💾SaveDataAndReloadWidget() }
    }
    
    enum 🔖TabTag {
        case rectangularWidget, circularWidget, inlineWidget, option ,about
    }
}

struct 📝RectangularWidgetTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    @FocusState var 🚩Focus: Bool
    @State private var 🚩ShowADMenuSheet: Bool = false
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .foregroundStyle(.background)
                            .onTapGesture { 🚩Focus = true }
                            .shadow(color: .secondary, radius: 1)
                        TextField("Input text", text: $📱.🎛RectangularData.text, axis: .vertical)
                            .font(.title2)
                            .focused($🚩Focus)
                            .frame(height: 150)
                            .padding()
                            .toolbar {
                                🗑EraseTextButton($📱.🎛RectangularData.text)
                                ToolbarItem(placement: .keyboard) {
                                    Button {
                                        🚩Focus = false
                                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                    } label: {
                                        Label("Done", systemImage: "keyboard.chevron.compact.down")
                                    }
                                }
                                ToolbarItem(placement: .navigationBarLeading) {
                                    ShareLink(item: 📱.🎛RectangularData.text)
                                        .disabled(📱.🎛RectangularData.text.isEmpty)
                                        .grayscale(1)
                                        .accessibilityLabel("Share")
                                }
                            }
                    }
                }
                .listRowBackground(Color.clear)
                📣ADBanner($🚩ShowADMenuSheet)
                🔗URLSchemeActionButton($📱.🎛RectangularData.text)
                🎚CustomizeSection()
            }
            .modifier(📣ADMenuSheet($🚩ShowADMenuSheet))
            .navigationTitle("Rectangular widget")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onOpenURL { 🔗 in
            if 🔗.description == "Rectangular" {
                DispatchQueue.main.async {
                    🚩Focus = true
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                }
            }
        }
    }
    struct 🎚CustomizeSection: View {
        @EnvironmentObject var 📱: 📱AppModel
        @AppStorage("UnfoldSection") var 🚩UnfoldSection: Bool = true
        var body: some View {
            DisclosureGroup(isExpanded: $🚩UnfoldSection) {
                🎚WeightPicker($📱.🎛RectangularData.fontWeight)
                🎚DesignPicker($📱.🎛RectangularData.fontDesign)
                🎚FontSizePicker($📱.🎛RectangularData.fontSize)
                🎚LevelPicker($📱.🎛RectangularData.level)
                🎚TextAlignmentPicker($📱.🎛RectangularData.multilineTextAlignment)
                🎚ItalicPicker($📱.🎛RectangularData.italic)
                🎚PlaceholderPicker($📱.🎛RectangularData.placeholder)
            } label: {
                Label("Customize", systemImage: "slider.horizontal.3")
                    .font(.caption)
            }
        }
    }
}

struct 📝CircularWidgetTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    @FocusState var 🚩Focus: Bool
    @State private var 🚩ShowADMenuSheet: Bool = false
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
                                .onTapGesture { 🚩Focus = true }
                            TextField("Input text", text: $📱.🎛CircularData.text, axis: .vertical)
                                .font(.title2)
                                .focused($🚩Focus)
                                .frame(width: (ⓢize * 5/7) - 6, height: (ⓢize * 5/7) - 6)
                                .toolbar {
                                    🗑EraseTextButton($📱.🎛CircularData.text)
                                    ToolbarItem(placement: .keyboard) {
                                        Button {
                                            🚩Focus = false
                                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                        } label: {
                                            Label("Done", systemImage: "keyboard.chevron.compact.down")
                                        }
                                    }
                                    ToolbarItem(placement: .navigationBarLeading) {
                                        ShareLink(item: 📱.🎛CircularData.text)
                                            .disabled(📱.🎛CircularData.text.isEmpty)
                                            .grayscale(1)
                                            .accessibilityLabel("Share")
                                    }
                                }
                        }
                        .frame(width: ⓢize, height: ⓢize)
                    }
                    .listRowBackground(Color.clear)
                }
                📣ADBanner($🚩ShowADMenuSheet)
                🔗URLSchemeActionButton($📱.🎛CircularData.text)
                🎚CustomizeSection()
            }
            .modifier(📣ADMenuSheet($🚩ShowADMenuSheet))
            .navigationTitle("Circular widget")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onOpenURL { 🔗 in
            if 🔗.description == "Circular" {
                DispatchQueue.main.async {
                    🚩Focus = true
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                }
            }
        }
    }
    struct 🎚CustomizeSection: View {
        @EnvironmentObject var 📱: 📱AppModel
        @AppStorage("UnfoldSection") var 🚩UnfoldSection: Bool = true
        var body: some View {
            DisclosureGroup(isExpanded: $🚩UnfoldSection) {
                Toggle(isOn: $📱.🎛CircularData.background) {
                    Label("Background",
                          systemImage: 📱.🎛CircularData.background ? "circle.dashed.inset.filled" : "circle.dashed")
                    .animation(.default, value: 📱.🎛CircularData.background)
                }
                🎚WeightPicker($📱.🎛CircularData.fontWeight)
                🎚DesignPicker($📱.🎛CircularData.fontDesign)
                🎚FontSizePicker($📱.🎛CircularData.fontSize)
                🎚LevelPicker($📱.🎛CircularData.level)
                🎚TextAlignmentPicker($📱.🎛CircularData.multilineTextAlignment)
                🎚ItalicPicker($📱.🎛CircularData.italic)
                🎚PlaceholderPicker($📱.🎛CircularData.placeholder)
            } label: {
                Label("Customize", systemImage: "slider.horizontal.3")
                    .font(.caption)
            }
        }
    }
}

struct 📝InlineWidgetTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    @FocusState var 🚩Focus: Bool
    @State private var 🚩ShowADMenuSheet: Bool = false
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Text(Date.now.formatted(.dateTime.day().weekday(.abbreviated)))
                            .font(.title2.bold())
                            .foregroundStyle(.tertiary)
                        TextField("Input text", text: $📱.🎛InlineData.text)
                            .font(.title2)
                            .focused($🚩Focus)
                            .textFieldStyle(.roundedBorder)
                            .toolbar {
                                🗑EraseTextButton($📱.🎛InlineData.text)
                                ToolbarItem(placement: .navigationBarLeading) {
                                    ShareLink(item: 📱.🎛InlineData.text)
                                        .disabled(📱.🎛InlineData.text.isEmpty)
                                        .grayscale(1)
                                        .accessibilityLabel("Share")
                                }
                            }
                    }
                    .listRowBackground(Color.clear)
                }
                📣ADBanner($🚩ShowADMenuSheet)
                🔗URLSchemeActionButton($📱.🎛InlineData.text)
                🎚CustomizeSection()
            }
            .modifier(📣ADMenuSheet($🚩ShowADMenuSheet))
            .navigationTitle("Inline widget")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onOpenURL { 🔗 in
            if 🔗.description == "Inline" {
                DispatchQueue.main.async {
                    🚩Focus = true
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                }
            }
        }
    }
    struct 🎚CustomizeSection: View {
        @EnvironmentObject var 📱: 📱AppModel
        @AppStorage("UnfoldSection") var 🚩UnfoldSection: Bool = true
        var body: some View {
            DisclosureGroup(isExpanded: $🚩UnfoldSection) {
                🎚PlaceholderPicker($📱.🎛InlineData.placeholder)
            } label: {
                Label("Customize", systemImage: "slider.horizontal.3")
                    .font(.caption)
            }
        }
    }
}

struct 🗑EraseTextButton: ToolbarContent {
    @State private var ⓞffsetX: CGFloat = 0
    @State private var 🚩EraseNow: Bool = false
    @Binding var ⓣext: String
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                UINotificationFeedbackGenerator().notificationOccurred(.warning)
                🚩EraseNow = true
                withAnimation {
                    ⓞffsetX = -32
                    ⓣext = ""
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    withAnimation(.default.speed(0.8)) {
                        🚩EraseNow = false
                        ⓞffsetX = 0
                    }
                }
            } label: {
                Label("Erase", systemImage: "eraser.line.dashed")
                    .opacity(🚩EraseNow ? 0 : 1)
            }
            .disabled(ⓣext.isEmpty)
            .foregroundStyle(ⓣext.isEmpty ? .tertiary : .secondary)
            .overlay {
                if 🚩EraseNow {
                    Image(systemName: "eraser.line.dashed")
                        .foregroundStyle(.secondary)
                        .offset(x: ⓞffsetX)
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
        NavigationLink {
            Picker("Placeholder", selection: $ⓟlaceholder) {
                ForEach(🄿laceholder.allCases) { placeholder in
                    Label(placeholder.rawValue, systemImage: placeholder.icon)
                }
            }
            .pickerStyle(.wheel)
        } label: {
            Label("Placeholder", systemImage: ⓟlaceholder.icon)
                .strikethrough(ⓟlaceholder == .nothing)
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
            Picker("Weight", selection: $ⓦeight) {
                ForEach(🅆eight.allCases) { weight in
                    Text(weight.rawValue)
                        .fontWeight(weight.value)
                }
            }
            .pickerStyle(.wheel)
        } label: {
            Label("Weight", systemImage: "bold")
                .fontWeight(ⓦeight.value)
                .badge(ⓦeight.rawValue)
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
            Picker("Design", selection: $ⓓesign) {
                ForEach(🄳esign.allCases) { design in
                    Text(design.rawValue)
                        .font(.system(.title, design: design.value, weight: nil))
                }
            }
            .pickerStyle(.wheel)
        } label: {
            Label("Design", systemImage: "a.magnify")
                .font(.system(.body, design: ⓓesign.value, weight: nil))
                .badge(ⓓesign.rawValue)
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
            Picker("Size", selection: $ⓢize) {
                ForEach(8..<50, id: \.self) { size in
                    Text(size.description)
                        .font(.system(size: CGFloat(size)))
                }
            }
            .pickerStyle(.wheel)
        } label: {
            Label("Size", systemImage: "textformat")
                .symbolRenderingMode(.hierarchical)
                .font(.system(size: CGFloat(ⓢize)))
                .badge(ⓢize.description)
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
            Picker("Level", selection: $ⓛevel) {
                ForEach(🄻evel.allCases) { level in
                    Text(level.rawValue)
                        .foregroundStyle(level.value)
                }
            }
            .pickerStyle(.wheel)
        } label: {
            Label {
                Text("Level")
                    .foregroundStyle(ⓛevel.value)
            } icon: {
                Image(systemName: "camera.filters")
                    .symbolRenderingMode(.hierarchical)
            }
            .badge(ⓛevel.rawValue)
        }
    }
    
    init(_ ⓛevel: Binding<🄻evel>) {
        self._ⓛevel = ⓛevel
    }
}

struct 🎚TextAlignmentPicker: View {
    @Binding var ⓐlignment: 🄼ultilineTextAlignment
    var body: some View {
        Picker(selection: $ⓐlignment) {
            ForEach(🄼ultilineTextAlignment.allCases) { alignment in
                Label(alignment.rawValue, systemImage: alignment.icon)
            }
        } label: {
            Text("Multi\ntext\nalignment")
                .animation(.default, value: ⓐlignment)
                .multilineTextAlignment(ⓐlignment.value)
                .font(.footnote)
        }
    }
    
    init(_ ⓐlignment: Binding<🄼ultilineTextAlignment>) {
        self._ⓐlignment = ⓐlignment
    }
}

struct 🎚ItalicPicker: View {
    @Binding var 🚩: Bool
    var body: some View {
        Toggle(isOn: $🚩) {
            Label("Italic", systemImage: "italic")
                .italic(🚩)
                .animation(.default, value: 🚩)
        }
    }
    
    init(_ 🚩: Binding<Bool>) {
        self._🚩 = 🚩
    }
}


struct 📣ADBanner: View {
    @Binding var 🚩ShowADMenuSheet: Bool
    var body: some View {
        Section {
            📣ADView(without: .LockInNote, $🚩ShowADMenuSheet)
        }
    }
    init(_ 🚩ShowADMenuSheet: Binding<Bool>) {
        self._🚩ShowADMenuSheet = 🚩ShowADMenuSheet
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
        @AppStorage("URLSchemeLeading") var 🔗Leading: String = ""
        @AppStorage("URLSchemeTrailing") var 🔗Trailing: String = ""
        @AppStorage("URLSchemeButtonTitle") var 🪧ButtonTitle: String = ""
        @AppStorage("EraseTextAfterAction") var 🚩EraseTextAfterAction: Bool = false
        var ⓛeading: String { 🔗Leading.isEmpty ? "① + " : 🔗Leading }
        var ⓣrailing: String { 🔗Trailing.isEmpty ? " + ②" : 🔗Trailing }
        var body: some View {
            List {
                Section {
                    VStack {
                        HStack {
                            if 🔗Leading.isEmpty {
                                Text("① +")
                                    .foregroundStyle(.secondary)
                            }
                            Text(🔗Leading + "TEXT" + 🔗Trailing)
                                .italic()
                                .font(.system(.subheadline, design: .monospaced))
                                .multilineTextAlignment(.center)
                                .padding(8)
                                .frame(minHeight: 100)
                            if 🔗Trailing.isEmpty {
                                Text("+ ②")
                                    .foregroundStyle(.secondary)
                            }
                        }
                        TextField("① URL scheme", text: $🔗Leading)
                        TextField("② Trailing component", text: $🔗Trailing)
                            .font(.subheadline)
                            .padding(.bottom, 4)
                    }
                    .textFieldStyle(.roundedBorder)
                } header: {
                    Text("URL scheme")
                }
                Section {
                    TextField("Input text of button", text: $🪧ButtonTitle)
                        .textFieldStyle(.roundedBorder)
                } header: {
                    Text("Button label")
                }
                Section {
                    Toggle(isOn: $🚩EraseTextAfterAction) {
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
    @AppStorage("URLSchemeLeading") var 🔗Leading: String = ""
    @AppStorage("URLSchemeTrailing") var 🔗Trailing: String = ""
    @AppStorage("URLSchemeButtonTitle") var 🪧ButtonTitle: String = ""
    @AppStorage("EraseTextAfterAction") var 🚩EraseTextAfterAction: Bool = false
    @Environment(\.openURL) var ⓞpenURL: OpenURLAction
    @Binding var ⓠuery: String
    var ⓤrl: URL? {
        let ⓣext = 🔗Leading + ⓠuery + 🔗Trailing
        guard let ⓔncodedText = ⓣext.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        return URL(string: ⓔncodedText)
    }
    var body: some View {
        if !🔗Leading.isEmpty {
            if let ⓤrl {
                Section {
                    Button {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        ⓞpenURL.callAsFunction(ⓤrl) { ⓐccepted in
                            if ⓐccepted && 🚩EraseTextAfterAction {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    ⓠuery = ""
                                }
                            }
                        }
                    } label: {
                        Label(LocalizedStringKey(🪧ButtonTitle.isEmpty ? "URL Scheme Action" : 🪧ButtonTitle),
                              systemImage: "command")
                            .font(.headline)
                    }
                    .disabled(ⓠuery.isEmpty)
                } header: {
                    if !🪧ButtonTitle.isEmpty {
                        Text("URL Scheme Action")
                    }
                }
            }
        }
    }
    init(_ ⓠuery: Binding<String>) {
        self._ⓠuery = ⓠuery
    }
}
