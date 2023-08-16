import SwiftUI

@main
struct LockInNote: App {
    @UIApplicationDelegateAdaptor var 📱: 📱AppModel
    private let 🛒 = 🛒InAppPurchaseModel(id: "LockInNote.adfree")
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(🛒)
        }
    }
}
