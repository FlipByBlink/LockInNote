import SwiftUI

struct ContentView: View {
    @EnvironmentObject var app: 📱AppModel
    var body: some View {
        NavigationStack {
            TabView(selection: self.$app.tab) {
                ForEach(📝NoteFamily.allCases) {
                    📝NoteTab()
                        .modifier(📋AddNoteToEnvironment($0))
                }
                🛠️OptionTab()
            }
            .navigationTitle(self.app.navigationTitle)
        }
        .sheet(item: self.$app.sheet) {
            switch $0 {
                case .noteDetail: 
                    📖NoteDetailView()
                case .customize(let ⓝoteFamily):
                    🎚️CustomizeMenu()
                        .modifier(📋AddNoteToEnvironment(ⓝoteFamily))
            }
        }
    }
}
