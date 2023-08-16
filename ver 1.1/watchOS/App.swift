import SwiftUI

@main
struct LockInNote: App {
    @WKApplicationDelegateAdaptor var 📱: 📱AppModel
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task { 📱.loadICloudTheFirstTime() }
        }
    }
}
