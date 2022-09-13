
import SwiftUI
import WidgetKit

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    @Environment(\.scenePhase) var ⓟhase: ScenePhase
    @State private var 🔖Tab: 🔖TabTag = .rectangularWidget
    
    var body: some View {
        TabView(selection: $🔖Tab) {
            📝RectangularWidgetTab()
                .tag(🔖TabTag.rectangularWidget)
                .tabItem { Label("Rectangular", systemImage: "rectangle.dashed") }
            📝InlineWidgetTab()
                .tag(🔖TabTag.inlineWidget)
                .tabItem { Label("Inline", systemImage: "textformat.abc") }
            Text("Circular")
                .tag(🔖TabTag.circularWidget)
                .tabItem { Label("Circular", systemImage: "circle.dashed") }
            🔩OptionTab()
                .tag(🔖TabTag.option)
                .tabItem { Label("Option", systemImage: "gearshape") }
            ℹ️AboutAppTab()
                .tag(🔖TabTag.about)
                .tabItem { Label("About App", systemImage: "questionmark") }
        }
        .onChange(of: ⓟhase) { 🆕 in
            print(ⓟhase,"->",🆕)
        }
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
    }
    
    enum 🔖TabTag {
        case inlineWidget, rectangularWidget, circularWidget, option, about
    }
}

struct 📝RectangularWidgetTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("note text", text: $📱.🎛RectangularData.text)
                        .font(.title3)
                        .textFieldStyle(.plain)
                        .scrollDismissesKeyboard(.immediately)
                        .onSubmit {
                            📱.💾SaveDatas()
                            WidgetCenter.shared.reloadAllTimelines()
                        }
                        .padding(.vertical, 32)
                }
                
                📣ADBanner()
                
                🎚ItalicPicker($📱.🎛RectangularData.italic)
                🎚WeightPicker($📱.🎛RectangularData.fontWeight)
                🎚DesignPicker($📱.🎛RectangularData.fontDesign)
                🎚StylePicker($📱.🎛RectangularData.fontStyle)
                🎚LevelPicker($📱.🎛RectangularData.level)
                🎚TextAlignmentPicker($📱.🎛RectangularData.multilineTextAlignment)
            }
            .navigationTitle("Rectangular widget")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct 📝InlineWidgetTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("note text", text: $📱.🎛InlineData.text)
                        .font(.title3)
                        .textFieldStyle(.plain)
                        .scrollDismissesKeyboard(.immediately)
                        .onSubmit {
                            📱.💾SaveDatas()
                            WidgetCenter.shared.reloadAllTimelines()
                        }
                        .padding(.vertical, 32)
                }
                
                📣ADBanner()
            }
            .navigationTitle("Inline widget")
            .navigationBarTitleDisplayMode(.inline)
        }
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

struct 🎚WeightPicker: View {
    @Binding var ⓦeight: 🅆eight
    var body: some View {
        NavigationLink {
            Picker(selection: $ⓦeight) {
                ForEach(🅆eight.allCases) { weight in
                    Text("Weight")
                        .fontWeight(weight.value)
                }
            } label: {
                Label("Weight", systemImage: "bold")
            }
            .pickerStyle(.wheel)
        } label: {
            Label("Weight", systemImage: "bold")
                .fontWeight(ⓦeight.value)
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
                    Text("Design")
                        .font(.system(.body, design: design.value, weight: nil))
                }
            } label: {
                Label("Design", systemImage: "a.magnify")
            }
            .pickerStyle(.wheel)
        } label: {
            Label("Design", systemImage: "a.magnify")
                .font(.system(.body, design: ⓓesign.value, weight: nil))
        }
    }
    
    init(_ ⓓesign: Binding<🄳esign>) {
        self._ⓓesign = ⓓesign
    }
}

struct 🎚StylePicker: View {
    @Binding var ⓢtyle: 🅂tyle
    var body: some View {
        NavigationLink {
            Picker(selection: $ⓢtyle) {
                ForEach(🅂tyle.allCases) { style in
                    Text("Style")
                        .font(style.value)
                }
            } label: {
                Label("Style", systemImage: "textformat")
                    .symbolRenderingMode(.hierarchical)
            }
            .pickerStyle(.wheel)
        } label: {
            Label("Style", systemImage: "textformat")
                .symbolRenderingMode(.hierarchical)
                .font(ⓢtyle.value)
        }
    }
    
    init(_ ⓢtyle: Binding<🅂tyle>) {
        self._ⓢtyle = ⓢtyle
    }
}

struct 🎚LevelPicker: View {
    @Binding var ⓛevel: 🄻evel
    var body: some View {
        NavigationLink {
            Picker(selection: $ⓛevel) {
                ForEach(🄻evel.allCases) { level in
                    Text("Level")
                        .foregroundStyle(level.value)
                }
            } label: {
                Label("Level", systemImage: "camera.filters")
                    .symbolRenderingMode(.hierarchical)
            }
            .pickerStyle(.wheel)
        } label: {
            Label("Level", systemImage: "camera.filters")
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(ⓛevel.value)
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
                switch alignment {
                    case .leading: Label("Leading", systemImage: alignment.icon)
                    case .center: Label("Center", systemImage: alignment.icon)
                    case .trailing: Label("Trailing", systemImage: alignment.icon)
                }
            }
            .labelStyle(.iconOnly)
        } label: {
            Label("Alignment", systemImage: ⓐlignment.icon)
        }
        .pickerStyle(.automatic)
    }
    
    init(_ ⓐlignment: Binding<🄼ultilineTextAlignment>) {
        self._ⓐlignment = ⓐlignment
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


struct 🔩OptionTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    
    var body: some View {
        NavigationStack {
            List {
                Toggle(isOn: $📱.🚩AutoLaunchKeyboard) {
                    Label("Auto keyboard launch", systemImage: "keyboard")
                }
                
                📣ADMenuLink()
            }
            .navigationTitle("Option")
        }
    }
}


//struct 🎚LevelPicker: View {
//    @EnvironmentObject var 📱: 📱AppModel
//    @State private var 🎚Level: 🄻evelEnum = .primary
//
//    var body: some View {
//        NavigationLink {
//            List {
//                Picker("", selection: $🎚Level) {
//                    ForEach(🄻evelEnum.allCases) { level in
//                        HStack {
//                            Text("Level")
//                                .padding(8)
//                                .foregroundStyle(ⓢhape(level))
//                            if level == .primary {
//                                Text("(default)")
//                                    .foregroundStyle(.secondary)
//                                    .font(.caption)
//                            }
//                        }
//                    }
//                }
//                .pickerStyle(.inline)
//            }
//        } label: {
//            HStack {
//                ForEach(🄻evelEnum.allCases) { level in
//                    Text("Aa")
//                        .foregroundStyle(ⓢhape(level))
//                        .underline(🎚Level == level)
//                }
//            }
//        }
//    }
//
//    func ⓢhape(_ level: 🄻evelEnum) -> HierarchicalShapeStyle {
//        switch level {
//            case .primary: return .primary
//            case .secondary: return .secondary
//            case .tertiary: return .tertiary
//            case .quaternary: return .quaternary
//        }
//    }
//}







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
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
