import SwiftUI

struct 📣ADContent: ViewModifier {
    @EnvironmentObject var 🛒: 🛒StoreModel
    @Environment(\.scenePhase) var scenePhase: ScenePhase
    @State private var ⓐpp: 📣MyApp = .pickUpAppWithout(.LockInNote)
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $🛒.🚩showADSheet) {
                📣ADSheet(self.ⓐpp)
            }
            .onChange(of: self.scenePhase) {
                if $0 == .inactive {
                    🛒.🚩showADSheet = false
                }
            }
    }
}
