import SwiftUI
import WidgetKit

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    @EnvironmentObject var 🛒: 🛒InAppPurchaseModel
    @Environment(\.scenePhase) var scenePhase
    @State private var tab: 🔖Tab = .rectangularWidget
    var body: some View {
        🔖TabView()
            .scrollDismissesKeyboard(.interactively)
            .modifier(💬RequestUserReview())
            .onSubmit { 📱.widgetsModel.saveData_reloadWidget_updateWCContext() }
            .onChange(of: self.scenePhase) {
                if $0 == .background { 📱.widgetsModel.saveData_reloadWidget_updateWCContext() }
            }
        //.modifier(📣ADSheet())
    }
}
