import SwiftUI

struct 🛒InAppPurchaseWindow: Scene {
    @ObservedObject var app: 📱AppModel
    var body: some Scene {
        Window(Text("In-App Purchase", tableName: "🌐AD&InAppPurchase"), id: "InAppPurchase") {
            🛒InAppPurchaseMenu()
                .environmentObject(self.app.inAppPurchaseModel)
        }
        .defaultSize(width: 400, height: 640)
        .commandsRemoved()
    }
    init(_ app: 📱AppModel) {
        self.app = app
    }
}
