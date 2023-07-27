import SwiftUI

struct 📣ADSheet: ViewModifier {
    @EnvironmentObject var 🛒: 🛒StoreModel
    @State private var targetApp: 📣MyApp = .pickUpAppWithout(.LockInNote)
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $🛒.🚩showADSheet) {
                📣ADView(self.targetApp, second: 8)
            }
    }
}
