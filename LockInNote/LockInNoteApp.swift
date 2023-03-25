import SwiftUI

@main
struct LockInNoteApp: App {
    @StateObject private var 📱 = 📱AppModel()
    @StateObject private var 🛒 = 🛒StoreModel(id: "LockInNote.adfree")
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modifier(🅂aveDataAndReloadWidget())
                .modifier(📣ADSheet())
                .modifier(💬RequestUserReview())
                .environmentObject(📱)
                .environmentObject(🛒)
        }
    }
}
