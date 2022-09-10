
import SwiftUI
import WidgetKit

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    @State private var 🔖Tab: 🔖TabTag = .main
    
    var body: some View {
        TabView(selection: $🔖Tab) {
            Color.gray
                .tag(🔖TabTag.main)
                .tabItem { Label("Main", systemImage: "text.justify.leading") }
            Color.red
                .tag(🔖TabTag.option)
                .tabItem { Label("Option", systemImage: "gearshape") }
            Color.blue
                .tag(🔖TabTag.about)
                .tabItem { Label("About App", systemImage: "questionmark") }
        }
    }
    
    enum 🔖TabTag {
        case main, option, about
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
