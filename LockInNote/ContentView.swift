
import SwiftUI
import WidgetKit

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    @Environment(\.scenePhase) var ⓟhase: ScenePhase
    @State private var 🔖Tab: 🔖TabTag = .inlineWidget
    
    var body: some View {
        TabView(selection: $🔖Tab) {
            📝InlineWidgetTab()
                .tag(🔖TabTag.inlineWidget)
                .tabItem { Label("Inline", systemImage: "textformat.abc") }
            Text("Rectangular")
                .tag(🔖TabTag.rectangularWidget)
                .tabItem { Label("Rectangular", systemImage: "rectangle.dashed") }
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
            if let ⓥalue = Int(🔗.description) {
                switch WidgetFamily(rawValue: ⓥalue) {
                    case .accessoryInline: 🔖Tab = .inlineWidget
                    case .accessoryRectangular: 🔖Tab = .rectangularWidget
                    case .accessoryCircular: 🔖Tab = .circularWidget
                    default: break
                }
            }
        }
    }
    
    enum 🔖TabTag {
        case inlineWidget, rectangularWidget, circularWidget, option, about
    }
}

struct 📝InlineWidgetTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        NavigationStack {
            if let index = 📱.ⓦidgetsData.firstIndex(where: { $0.id == .inline }) {
                List {
                    Section {
                        TextField("note text", text: $📱.ⓦidgetsData[index].text)
                            .font(.title3)
                            .textFieldStyle(.roundedBorder)
                            .scrollDismissesKeyboard(.immediately)
                            .onSubmit {
                                📱.💾SaveDatas()
                                WidgetCenter.shared.reloadAllTimelines()
                            }
                        NavigationLink {
                            Text(📱.ⓦidgetsData[index].family.rawValue)
                        } label: {
                            Label("Customize", systemImage: "slider.horizontal.3")
                                .font(.caption)
                        }
                    }
                }
                .navigationTitle("Inline widget")
            } else {
                Text("🐛Bug")
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




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
