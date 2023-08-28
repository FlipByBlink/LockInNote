import SwiftUI

@main
struct watchOSApp: App {
    @WKApplicationDelegateAdaptor var model: 📱AppModel
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    init() {
        🗄️MigrationFromVer_1_1.execute()
    }
}
