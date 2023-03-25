import SwiftUI
import WidgetKit
import WatchConnectivity

class 📱AppModel: NSObject, ObservableObject {
    @Published var widgetsModel: 🎛WidgetsModel = .init()
    
    func saveDataAndReloadWidget() {
        self.widgetsModel.save()
        WidgetCenter.shared.reloadAllTimelines()
    }
}

extension 📱AppModel: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
        return true
    }
}

extension 📱AppModel: WCSessionDelegate {
    //Required
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //Do something
    }
    //Required
    func sessionDidBecomeInactive(_ session: WCSession) {
        //Nothing
    }
    //Required
    func sessionDidDeactivate(_ session: WCSession) {
        session.activate()
    }
    //Optional
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        Task { @MainActor in
//            if let ⓒontext = 🄲ontext.decode(applicationContext) {
//                self.ⓐpplyContext(ⓒontext)
//            } else {
//                assertionFailure()
//            }
        }
    }
}
