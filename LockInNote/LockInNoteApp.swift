import SwiftUI

@main
struct LockInNoteApp: App {
    @UIApplicationDelegateAdaptor var 📱: 📱AppModel
    private let 🛒 = 🛒StoreModel(id: "LockInNote.adfree")
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(🛒)
        }
    }
}
