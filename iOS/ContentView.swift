import SwiftUI

struct ContentView: View {
    @EnvironmentObject var app: 📱AppModel
    var body: some View {
        TabView(selection: self.$app.tab) {
            ForEach(📝NoteFamily.allCases) {
                📝NoteTab()
                    .modifier(📋AddNoteToEnvironment($0))
            }
            🛠️OptionTab()
            ℹ️InfoTab()
        }
        .modifier(💬RequestUserReview())
        .sheet(item: self.$app.sheet) {
            switch $0 {
                case .customize(let ⓝoteFamily):
                    🎚️CustomizeMenu()
                        .modifier(📋AddNoteToEnvironment(ⓝoteFamily))
                case .onboarding:
                    Text("Onboarding")
                case .ad:
                    Text("AD")
            }
        }
    }
}




//import WatchConnectivity
//struct SyncAppleWatch: ViewModifier {
//    @Environment(\.scenePhase) var scenePhase
//    func body(content: Content) -> some View {
//        content
//            .onChange(of: scenePhase) {
//                if $0 == .background {
//                    WCSession.default.sendMessage(["pushedFromIPhone" : true], replyHandler: nil)
//                }
//            }
//    }
//}
