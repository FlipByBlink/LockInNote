import SwiftUI

struct 📣ADSheet: ViewModifier {
    @EnvironmentObject var 🛒: 🛒StoreModel
    @Environment(\.scenePhase) var scenePhase
    @State private var ⓐpp: 📣MyApp = .pickUpAppWithout(.LockInNote)
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $🛒.🚩showADSheet) {
                📣ADView(self.ⓐpp, second: 8)
            }
            .onChange(of: self.scenePhase) {
                if $0 == .inactive {
                    🛒.🚩showADSheet = false
                }
            }
    }
}
