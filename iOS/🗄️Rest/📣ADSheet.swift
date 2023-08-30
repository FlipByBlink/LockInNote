import SwiftUI

struct 📣ADSheet: View {
    @EnvironmentObject var model: 🛒InAppPurchaseModel
    @State private var app: 📣ADTargetApp = .pickUpAppWithout(.LockInNote)
    var body: some View {
        📣ADView(self.app, second: 12)
    }
}
