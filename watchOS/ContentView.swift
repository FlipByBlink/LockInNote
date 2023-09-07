import SwiftUI

struct ContentView: View {
    @EnvironmentObject var app: 📱AppModel
    var body: some View {
        TabView(selection: self.$app.tab) {
            ForEach(📝NoteFamily.allCases) {
               📝NoteTab()
                    .modifier(📋AddNoteToEnvironment($0))
            }
            ℹ️InfoTab()
        }
        .sheet(item: self.$app.sheet) {
            switch $0 {
                case .noteDetail:
                    📖NoteDetailView()
                case .customize(let ⓣarget):
                    🎚️CustomizeMenu()
                        .modifier(📋AddNoteToEnvironment(ⓣarget))
            }
        }
        .modifier(🪧ReloadOnActive())
        .onOpenURL { self.app.handle($0) }
    }
}
