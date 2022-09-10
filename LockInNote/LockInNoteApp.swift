
import SwiftUI

@main
struct LockInNoteApp: App {
    let 📱 = 📱AppModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(📱)
        }
    }
}
