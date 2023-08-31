import SwiftUI

@main
struct watchOSApp: App {
    @WKApplicationDelegateAdaptor var appModel: 📱AppModel
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
