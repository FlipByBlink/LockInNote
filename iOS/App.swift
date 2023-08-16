import SwiftUI

@main
struct iOSApp: App {
    @UIApplicationDelegateAdaptor var model: 📱AppModel
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
