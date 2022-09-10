
import SwiftUI

@main
struct LockInNoteApp: App {
    let 📱 = 📱AppModel()
    let 🛒 = 🛒StoreModel(id: "LockInNote.adfree")
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(📱)
                .environmentObject(🛒)
        }
    }
}
