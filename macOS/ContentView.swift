import SwiftUI

struct ContentView: View {
    @EnvironmentObject var app: 📱AppModel
    var body: some View {
        NavigationStack {
            📝NoteEditor()
                .modifier(📋AddNoteToEnvironment())
        }
        .frame(minWidth: 400, idealWidth: 400, minHeight: 180, idealHeight: 180)
        .toolbarBackground(.clear, for: .automatic)
        .sheet(item: self.$app.sheet) {
            switch $0 {
                case .onboarding: Text("Onboarding")
                case .ad: Text("AD")
            }
        }
        .modifier(🔲WindowEdgeFeedback())
        .modifier(📖OpenNoteFromWidget())
        .animation(.default, value: self.app.target)
        .environmentObject(self.app.inAppPurchaseModel)
    }
}
