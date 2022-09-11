
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
            Text("Option")
                .tag(🔖TabTag.option)
                .tabItem { Label("Option", systemImage: "gearshape") }
            ℹ️AboutAppTab()
                .tag(🔖TabTag.about)
                .tabItem { Label("About App", systemImage: "questionmark") }
        }
        .onChange(of: ⓟhase) { 🆕 in
            print(ⓟhase,"->",🆕)
            if 🆕 == .active {
                WidgetCenter.shared.getCurrentConfigurations { ⓡesult in
                    switch ⓡesult {
                        case .success(let success):
                            DispatchQueue.main.async {
                                📱.Infos = success
                            }
                        case .failure(let failure):
                            print(failure)
                    }
                }
            }
        }
    }
    
    enum 🔖TabTag {
        case widgets, option, about
    }
}

struct 📝WidgetsTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    @State private var 🎚Style: Font.TextStyle = .body
    @State private var 🎚Weight: Font.Weight = .regular
    @State private var 🎚Design: Font.Design = .default
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    List {
                        Picker("", selection: $🎚Style) {
                            ForEach(Font.TextStyle.allCases, id: \.self) { style in
                                HStack {
                                    Text("Font style")
                                        .font(.system(style, design: 🎚Design, weight: 🎚Weight))
                                        .padding(8)
                                    if style == .body {
                                        Text("(default)")
                                            .foregroundStyle(.secondary)
                                            .font(.caption)
                                    }
                                }
                            }
                        }
                        .pickerStyle(.inline)
                    }
                } label: {
                    HStack {
                        ForEach(Font.TextStyle.allCases, id: \.self) { style in
                            Text("A")
                                .font(.system(style))
                                .underline(🎚Style == style)
                            
                        }
                    }
                }
                
                let weights: [Font.Weight] = [.thin, .light, .regular, .medium, .bold, .heavy, .black]
                NavigationLink {
                    List {
                        Picker("", selection: $🎚Weight) {
                            ForEach(weights, id: \.self) { weight in
                                HStack {
                                    Text("Font weight")
                                        .font(.system(🎚Style, design: 🎚Design, weight: weight))
                                        .padding(8)
                                    if weight == .regular {
                                        Text("(default)")
                                            .foregroundStyle(.secondary)
                                            .font(.caption)
                                    }
                                }
                            }
                        }
                        .pickerStyle(.inline)
                    }
                } label: {
                    HStack {
                        ForEach(weights, id: \.self) { weight in
                            Text("Aa")
                                .fontWeight(weight)
                                .underline(🎚Weight == weight)
                        }
                    }
                }
                
                let designs: [Font.Design] = [.default, .rounded, .serif, .monospaced]
                NavigationLink {
                    List {
                        Picker("", selection: $🎚Design) {
                            ForEach(designs, id: \.self) { design in
                                HStack {
                                    Text("Font design")
                                        .font(.system(🎚Style, design: design, weight: 🎚Weight))
                                        .padding(8)
                                    if design == .default {
                                        Text("(default)")
                                            .foregroundStyle(.secondary)
                                            .font(.caption)
                                    }
                                }
                            }
                        }
                        .pickerStyle(.inline)
                    }
                } label: {
                    HStack {
                        ForEach(designs, id: \.self) { design in
                            Text("Aa")
                                .font(.system(.body, design: design))
                                .underline(🎚Design == design)
                        }
                    }
                }
                
                🎚LevelPicker()
            }
        }
    }
}


struct 🎚LevelPicker: View {
    @EnvironmentObject var 📱: 📱AppModel
    @State private var 🎚Level: 🄻evelEnum = .primary
    
    var body: some View {
        NavigationLink {
            List {
                Picker("", selection: $🎚Level) {
                    ForEach(🄻evelEnum.allCases) { level in
                        HStack {
                            Text("Level")
                                .padding(8)
                                .foregroundStyle(ⓢhape(level))
                            if level == .primary {
                                Text("(default)")
                                    .foregroundStyle(.secondary)
                                    .font(.caption)
                            }
                        }
                    }
                }
                .pickerStyle(.inline)
            }
        } label: {
            HStack {
                ForEach(🄻evelEnum.allCases) { level in
                    Text("Aa")
                        .foregroundStyle(ⓢhape(level))
                        .underline(🎚Level == level)
                }
            }
        }
    }
    
    func ⓢhape(_ level: 🄻evelEnum) -> HierarchicalShapeStyle {
        switch level {
            case .primary: return .primary
            case .secondary: return .secondary
            case .tertiary: return .tertiary
            case .quaternary: return .quaternary
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
