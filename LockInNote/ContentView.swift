
import SwiftUI
import WidgetKit

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    @Environment(\.scenePhase) var ⓟhase: ScenePhase
    @State private var 🔖Tab: 🔖TabTag = .widgets
    
    var body: some View {
        TabView(selection: $🔖Tab) {
            📝WidgetsTab()
                .tag(🔖TabTag.widgets)
                .tabItem { Label("Widgets", systemImage: "rectangle.and.pencil.and.ellipsis") }
            🔩OptionTab()
                .tag(🔖TabTag.option)
                .tabItem { Label("Option", systemImage: "gearshape") }
            ℹ️AboutAppTab()
                .tag(🔖TabTag.about)
                .tabItem { Label("About App", systemImage: "questionmark") }
        }
        .onChange(of: ⓟhase) { 🆕 in
            print(ⓟhase,"->",🆕)
            if 🆕 == .active {
                📱.GetLatestWidgetInfo()
            }
        }
        .onOpenURL { 🔗 in
            if !📱.ⓦidgetsData.isEmpty {
                📱.🚩ShowWidgetSheet = true
                📱.🆔OpenedWidgetID = 🔗.description
            }
            🔖Tab = .widgets
        }
        .sheet(isPresented: $📱.🚩ShowWidgetSheet) {
            Text("WidgetSheet")
        }
    }
    
    enum 🔖TabTag {
        case widgets, option, about
    }
}

struct 📝WidgetsTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        NavigationStack {
            List {
                if 📱.ⓐctiveWidgets.isEmpty {
                    Text("Widget is empty.")
                        .foregroundStyle(.secondary)
                        .padding(.vertical)
                } else {
                    ForEach(🅆idgetType.allCases) { type in
                        if 📱.ⓐctiveWidgets.contains(type) {
                            🅆idgetSection(type: type)
                        }
                    }
                }
            }
            .navigationTitle("Widgets")
            .animation(.default, value: 📱.ⓐctiveWidgets.count)
        }
    }
    
    struct 🅆idgetSection: View {
        @EnvironmentObject var 📱: 📱AppModel
        var type: 🅆idgetType
        var body: some View {
            if let index = 📱.ⓦidgetsData.firstIndex(where: {$0.id==type}) {
                Section {
                    TextField("field", text: $📱.ⓦidgetsData[index].text, axis: .vertical)
                        .textFieldStyle(.roundedBorder)
                        .lineLimit(3)
                        .onSubmit {
                            📱.💾SaveDatas()
                            WidgetCenter.shared.reloadAllTimelines()
                        }
                    NavigationLink {
                        Text(📱.ⓦidgetsData[index].kind.rawValue)
                        Text(📱.ⓦidgetsData[index].family.rawValue)
                    } label: {
                        Label("Customize", systemImage: "slider.horizontal.3")
                            .font(.caption)
                    }
                } header: {
                    Text(📱.ⓦidgetsData[index].family.rawValue)
                }
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
