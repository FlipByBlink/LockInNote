import SwiftUI

struct ContentView: View {
    @EnvironmentObject var app: 📱AppModel
    var body: some View {
        TabView(selection: self.$app.tab) {
            📝NoteTab().environmentObject(self.app.primaryNote)
            📝NoteTab().environmentObject(self.app.secondaryNote)
            📝NoteTab().environmentObject(self.app.tertiaryNote)
            🛠️OptionTab()
                .tag(🔖Tab.option)
                .tabItem { Label("Option", systemImage: "gearshape") }
            ℹ️InfoTab()
                .tag(🔖Tab.info)
                .tabItem { Label("Info", systemImage: "info") }
        }
        .sheet(item: self.$app.sheet) {
            switch $0 {
                case .customize(let ⓝoteFamily):
                    🎚️CustomizeMenu(ⓝoteFamily)
                case .onboarding:
                    Text("Onboarding")
                case .ad:
                    Text("AD")
            }
        }
    }
}
