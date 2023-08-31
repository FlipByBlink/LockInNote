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
        .sheet(item: self.$app.sheet) {
            switch $0 {
                case .customize(let ⓝoteFamily):
                    🎚️CustomizeMenu()
                        .modifier(📋AddNoteToEnvironment(ⓝoteFamily))
                case .onboarding:
                    💁HowToOnBoarding()
                case .ad:
                    📣ADSheet()
            }
        }
        .onOpenURL { self.app.handle($0) }
        .modifier(💁OnBoardingHandle())
        .modifier(💬RequestUserReview())
        .environmentObject(self.app.inAppPurchaseModel)
    }
}
