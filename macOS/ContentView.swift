import SwiftUI

struct ContentView: View {
    @EnvironmentObject var app: 📱AppModel
    var body: some View {
        NavigationStack {
            switch self.app.target {
                case .primary: 📝NoteEditor().environmentObject(self.app.primaryNote)
                case .secondary: 📝NoteEditor().environmentObject(self.app.secondaryNote)
                case .tertiary: 📝NoteEditor().environmentObject(self.app.tertiaryNote)
            }
        }
        .frame(minWidth: 400, idealWidth: 400, minHeight: 180, idealHeight: 180)
        .toolbarBackground(.clear, for: .automatic)
        .sheet(item: self.$app.sheet) {
            switch $0 {
                case .onboarding: Text("Onboarding")
                case .ad: Text("AD")
            }
        }
        .overlay {
            if self.app.playingFeedback {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.tint, lineWidth: 5)
                    .ignoresSafeArea()
            }
        }
        .modifier(📖OpenNoteFromWidget())
        .animation(.default.speed(2), value: self.app.playingFeedback)
        .animation(.default, value: self.app.target)
        .environmentObject(self.app.inAppPurchaseModel)
    }
}
