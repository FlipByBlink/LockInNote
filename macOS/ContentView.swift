import SwiftUI

struct ContentView: View {
    @EnvironmentObject var app: 📱AppModel
    var body: some View {
        NavigationStack {
            📝NoteEditor()
                .modifier(📋AddNoteToEnvironment())
        }
        .frame(minWidth: 380, idealWidth: 380, minHeight: 180, idealHeight: 180)
        .toolbarBackground(.clear, for: .automatic)
        .sheet(item: self.$app.sheet) {
            switch $0 {
                case .onboarding: Text("Onboarding") //TODO: 実装
                case .ad: Text("AD") //TODO: 実装
            }
        }
        .modifier(🔲WindowEdgeFeedback())
        .modifier(📖OpenNoteFromWidget())
        .animation(.default, value: self.app.target)
        .environmentObject(self.app.inAppPurchaseModel)
    }
}
