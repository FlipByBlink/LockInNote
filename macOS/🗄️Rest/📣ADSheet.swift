import SwiftUI

struct 📣ADSheet: View {
    @EnvironmentObject var model: 🛒InAppPurchaseModel
    @State private var app: 📣ADTargetApp = .pickUpAppWithout(.LockInNote)
    var body: some View {
        📣ADContent(self.app, second: 8)
    }
}
