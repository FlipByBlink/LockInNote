import SwiftUI

@main
struct iOSApp: App {
    @UIApplicationDelegateAdaptor var appModel: 📱AppModel
    private let iapModel: 🛒InAppPurchaseModel = .init(id: "LockInNote.adfree")
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(self.iapModel)
        }
    }
    init() {
        🗄️MigrationFromVer_1_1.execute()
    }
}
