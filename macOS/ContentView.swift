import SwiftUI

struct ContentView: View {
    @EnvironmentObject var app: 📱AppModel
    var body: some View {
        NavigationStack {
            📝NoteEditor()
                .modifier(📋AddNoteToEnvironment())
        }
        .frame(minWidth: 390, idealWidth: 390, minHeight: 180, idealHeight: 180)
        .toolbarBackground(.clear, for: .automatic)
        .modifier(📣ADSheet())
        .modifier(🔲WindowEdgeFeedback())
        .animation(.default, value: self.app.target)
        .environmentObject(self.app.inAppPurchaseModel)
    }
}
