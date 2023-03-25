import SwiftUI

@main
struct LockInNoteApp: App {
    @UIApplicationDelegateAdaptor var 📱: 📱AppModel
    @StateObject private var 🛒 = 🛒StoreModel(id: "LockInNote.adfree")
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modifier(🅂aveDataAndReloadWidget())
                .modifier(📣ADSheet())
                .environmentObject(📱)
                .environmentObject(🛒)
        }
    }
}
