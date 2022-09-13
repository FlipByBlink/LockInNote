
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
            📝InlineWidgetTab()
                .tag(🔖TabTag.inlineWidget)
                .tabItem { Label("Inline", systemImage: "textformat.abc") }
            📝CircularWidgetTab()
                .tag(🔖TabTag.circularWidget)
                .tabItem { Label("Circular", systemImage: "circle.dashed") }
            ℹ️AboutAppTab()
                .tag(🔖TabTag.about)
                .tabItem { Label("About App", systemImage: "questionmark") }
        }
        .animation(.default.speed(0.5), value: 🛒.🚩ADisActive)
        .scrollDismissesKeyboard(.immediately)
        .onOpenURL { 🔗 in
            DispatchQueue.main.async {
                switch 🔗.description {
                    case "Rectangular": 🔖Tab = .rectangularWidget
                    case "Inline": 🔖Tab = .inlineWidget
                    case "Circular": 🔖Tab = .circularWidget
                    default: print("🐛")
                }
            }
        }
        .onChange(of: 📱.🎛RectangularData) { _ in 📱.💾SaveDataAndReloadWidget() }
        .onChange(of: 📱.🎛InlineData) { _ in 📱.💾SaveDataAndReloadWidget() }
        .onChange(of: 📱.🎛CircularData) { _ in 📱.💾SaveDataAndReloadWidget() }
    }
    
    enum 🔖TabTag {
        case inlineWidget, rectangularWidget, circularWidget, about
    }
}

struct 📝RectangularWidgetTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    @FocusState var 🚩Focus: Bool
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Note text", text: $📱.🎛RectangularData.text, axis: .vertical)
                        .focused($🚩Focus)
                        .font(.title3)
                        .padding(.vertical, 24)
                        .toolbar {
                            ToolbarItem(placement: .keyboard) {
                                Button {
                                    🚩Focus = false
                                } label: {
                                    Label("Done", systemImage: "checkmark")
                                }
                            }
                        }
                }
                
                📣ADBanner()
                
                🎚WeightPicker($📱.🎛RectangularData.fontWeight)
                🎚DesignPicker($📱.🎛RectangularData.fontDesign)
                🎚FontSizePicker($📱.🎛RectangularData.fontSize)
                🎚LevelPicker($📱.🎛RectangularData.level)
                🎚TextAlignmentPicker($📱.🎛RectangularData.multilineTextAlignment)
                🎚ItalicPicker($📱.🎛RectangularData.italic)
                🎚PlaceholderPicker($📱.🎛RectangularData.placeholder)
            }
            .navigationTitle("Rectangular widget")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onOpenURL { 🔗 in
            if 🔗.description == "Rectangular" {
                DispatchQueue.main.async {
                    🚩Focus = true
                }
            }
        }
    }
}

struct 📝InlineWidgetTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    @FocusState var 🚩Focus: Bool
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Note text", text: $📱.🎛InlineData.text)
                        .focused($🚩Focus)
                        .font(.title3)
                        .padding(.vertical, 24)
                }
                
                📣ADBanner()
                
                🎚PlaceholderPicker($📱.🎛InlineData.placeholder)
            }
            .navigationTitle("Inline widget")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onOpenURL { 🔗 in
            if 🔗.description == "Inline" {
                DispatchQueue.main.async {
                    🚩Focus = true
                }
            }
        }
    }
}

struct 📝CircularWidgetTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    @FocusState var 🚩Focus: Bool
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Note text", text: $📱.🎛CircularData.text)
                        .focused($🚩Focus)
                        .font(.title3)
                        .padding(.vertical, 24)
                }
                
                📣ADBanner()
                
                Toggle(isOn: $📱.🎛CircularData.background) {
                    Label("Background",
                          systemImage: 📱.🎛CircularData.background ? "circle.dashed.inset.filled" : "circle.dashed")
                }
                🎚WeightPicker($📱.🎛CircularData.fontWeight)
                🎚DesignPicker($📱.🎛CircularData.fontDesign)
                🎚FontSizePicker($📱.🎛CircularData.fontSize)
                🎚LevelPicker($📱.🎛CircularData.level)
                🎚TextAlignmentPicker($📱.🎛CircularData.multilineTextAlignment)
                🎚ItalicPicker($📱.🎛CircularData.italic)
                🎚PlaceholderPicker($📱.🎛CircularData.placeholder)
            }
            .navigationTitle("Circular widget")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onOpenURL { 🔗 in
            if 🔗.description == "Circular" {
                DispatchQueue.main.async {
                    🚩Focus = true
                }
            }
        }
    }
}

struct 🎚PlaceholderPicker: View {
    @Binding var ⓟlaceholder: 🄿laceholder
    var body: some View {
        Menu {
            Picker("Placeholder", selection: $ⓟlaceholder) {
                ForEach(🄿laceholder.allCases) { placeholder in
                    if let icon = placeholder.icon {
                        Label(placeholder.rawValue, systemImage: icon)
                    } else {
                        Text(LocalizedStringKey(placeholder.rawValue))
                    }
                }
            }
        } label: {
            HStack {
                Label("Placeholder", systemImage: "square.dotted")
                Spacer()
                Group {
                    if let icon = ⓟlaceholder.icon {
                        Image(systemName: icon)
                    } else {
                        Text(LocalizedStringKey(ⓟlaceholder.rawValue))
                    }
                }.foregroundColor(.secondary)
            }
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
            Picker(selection: $ⓦeight) {
                ForEach(🅆eight.allCases) { weight in
                    Text(weight.rawValue)
                        .fontWeight(weight.value)
                }
            } label: {
                Label("Weight", systemImage: "bold")
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
            Picker(selection: $ⓓesign) {
                ForEach(🄳esign.allCases) { design in
                    Text(design.rawValue)
                        .font(.system(.body, design: design.value, weight: nil))
                }
            } label: {
                Label("Design", systemImage: "a.magnify")
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
            Picker(selection: $ⓢize) {
                ForEach(8..<50, id: \.self) { size in
                    Text(size.description)
                        .font(.system(size: CGFloat(size)))
                }
            } label: {
                Label("Size", systemImage: "textformat")
                    .symbolRenderingMode(.hierarchical)
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
            Picker(selection: $ⓛevel) {
                ForEach(🄻evel.allCases) { level in
                    Text(level.rawValue)
                        .foregroundStyle(level.value)
                }
            } label: {
                Label("Level", systemImage: "camera.filters")
                    .symbolRenderingMode(.hierarchical)
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
                .padding(.leading)
                .multilineTextAlignment(ⓐlignment.value)
                .font(.footnote)
        }
        .pickerStyle(.automatic)
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
        }
    }
    
    init(_ 🚩: Binding<Bool>) {
        self._🚩 = 🚩
    }
}


struct 📣ADBanner: View {
    @EnvironmentObject var 🛒: 🛒StoreModel
    var body: some View {
        if 🛒.🚩ADisActive {
            Section {
                📣ADView()
            }
        }
    }
}


struct ℹ️AboutAppTab: View {
    var body: some View {
        NavigationView {
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
                
                📣ADMenuLink()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
