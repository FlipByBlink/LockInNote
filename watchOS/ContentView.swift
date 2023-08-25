import SwiftUI

struct ContentView: View {
    @EnvironmentObject var app: 📱AppModel
    var body: some View {
        NavigationStack {
            TabView(selection: self.$app.tab) {
                📝NoteTab()
                    .environmentObject(self.app.primaryNote)
                    .tag(🔖Tab.note(.primary))
                📝NoteTab()
                    .environmentObject(self.app.secondaryNote)
                    .tag(🔖Tab.note(.secondary))
                📝NoteTab()
                    .environmentObject(self.app.tertiaryNote)
                    .tag(🔖Tab.note(.tertiary))
                🛠️OptionTab()
                    .tag(🔖Tab.menu)
            }
            .navigationTitle(self.app.navigationTitle)
        }
        .sheet(item: self.$app.sheet) {
            switch $0 {
                case .noteDetail: 📖NoteDetailView()
                case .customize(let ⓝoteFamily): 🎚️CustomizeMenu(ⓝoteFamily)
            }
        }
    }
}
