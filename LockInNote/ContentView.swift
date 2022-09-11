
import SwiftUI
import WidgetKit

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    @State private var 🔖Tab: 🔖TabTag = .detail
    
    var body: some View {
        TabView(selection: $🔖Tab) {
            📝DetailTab()
                .tag(🔖TabTag.detail)
                .tabItem { Label("Detail", systemImage: "doc") }
            Text("Main")
                .tag(🔖TabTag.main)
                .tabItem { Label("Main", systemImage: "text.justify.leading") }
            Text("Option")
                .tag(🔖TabTag.option)
                .tabItem { Label("Option", systemImage: "gearshape") }
            ℹ️AboutAppTab()
                .tag(🔖TabTag.about)
                .tabItem { Label("About App", systemImage: "questionmark") }
        }
    }
    
    enum 🔖TabTag {
        case detail, main, option, about
    }
}

struct 📝DetailTab: View {
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
                                Text("Font style!")
                                    .font(.system(style, design: 🎚Design, weight: 🎚Weight))
                                    .padding(8)
                                    .underline(style == .body)
                            }
                        }
                        .pickerStyle(.inline)
                    }
                } label: {
                    HStack {
                        ForEach(Font.TextStyle.allCases, id: \.self) { style in
                            Text("A")
                                .font(.system(style))
                                .foregroundStyle(🎚Style == style ? .primary : .tertiary)
                        }
                    }
                }
                
                let weights: [Font.Weight] = [.regular, .medium, .bold, .heavy, .black]
                NavigationLink {
                    List {
                        Picker("", selection: $🎚Weight) {
                            ForEach(weights, id: \.self) { weight in
                                Text("Font weight!")
                                    .font(.system(🎚Style, design: 🎚Design, weight: weight))
                                    .padding(8)
                                    .underline(weight == .regular)
                            }
                        }
                        .pickerStyle(.inline)
                    }
                } label: {
                    HStack {
                        ForEach(weights, id: \.self) { weight in
                            Text("Aa")
                                .fontWeight(weight)
                                .foregroundStyle(🎚Weight == weight ? .primary : .tertiary)
                        }
                    }
                }
                
                let designs: [Font.Design] = [.default, .rounded, .serif, .monospaced]
                NavigationLink {
                    List {
                        Picker("", selection: $🎚Design) {
                            ForEach(designs, id: \.self) { design in
                                Text("Font design!")
                                    .font(.system(🎚Style, design: design, weight: 🎚Weight))
                                    .padding(8)
                                    .underline(design == .default)
                            }
                        }
                        .pickerStyle(.inline)
                    }
                } label: {
                    HStack {
                        ForEach(designs, id: \.self) { design in
                            Text("Aa")
                                .font(.system(.body, design: design))
                                .foregroundStyle(🎚Design == design ? .primary : .tertiary)
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
    @State private var 🎚Level: LevelEnum = .primary
    
    var body: some View {
        NavigationLink {
            List {
                Picker("", selection: $🎚Level) {
                    ForEach(LevelEnum.allCases) { level in
                        Text("Hierarchical level!")
                            .padding(8)
                            .foregroundStyle(level.shape)
                            .underline(level == .primary)
                    }
                }
                .pickerStyle(.inline)
            }
        } label: {
            HStack {
                ForEach(LevelEnum.allCases) { level in
                    Text("Aa")
                        .foregroundStyle(level.shape)
                        .border(.primary, width: 🎚Level == level ? 1 : 0)
                }
            }
        }
    }
    
    enum LevelEnum: CaseIterable, Identifiable {
        case primary
        case secondary
        case tertiary
        case quaternary
        var id: LevelEnum { self }
        
        var shape: HierarchicalShapeStyle {
            switch self {
                case .primary: return .primary
                case .secondary: return .secondary
                case .tertiary: return .tertiary
                case .quaternary: return .quaternary
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
                                Text("Application for iPhone / iPad")
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
