import SwiftUI

@main
struct LIN_Watch_App: App {
    @WKApplicationDelegateAdaptor var 📱: 📱AppModel
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task { self.📱.loadICloudTheFirstTime() }
        }
        //.backgroundTask(.watchConnectivity) { _ in
        //}
    }
}
