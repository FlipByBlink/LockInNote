import SwiftUI

@main
struct iOSApp: App {
    @UIApplicationDelegateAdaptor var appModel: 📱AppModel
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
