import SwiftUI

struct ContentView: View {
    @EnvironmentObject var app: 📱AppModel
    var body: some View {
        NavigationStack {
            switch self.app.target {
                case .primary: 📝NoteView().environmentObject(self.app.primaryNote)
                case .secondary: 📝NoteView().environmentObject(self.app.secondaryNote)
                case .tertiary: 📝NoteView().environmentObject(self.app.tertiaryNote)
            }
        }
        .frame(minWidth: 440, idealWidth: 440, minHeight: 200, idealHeight: 200)
        .toolbarBackground(.clear, for: .automatic)
        .sheet(item: self.$app.sheet) {
            switch $0 {
                case .onboarding: Text("Onboarding")
                case .ad: Text("AD")
            }
        }
        .overlay {
            if self.app.playFeedback {
                RoundedRectangle(cornerRadius: 12).stroke(.tint, lineWidth: 5).ignoresSafeArea()
            }
        }
        .animation(.default.speed(2), value: self.app.playFeedback)
        .animation(.default, value: self.app.target)
    }
}
