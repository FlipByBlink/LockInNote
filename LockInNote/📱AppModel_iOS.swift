import SwiftUI
import WidgetKit
import WatchConnectivity

@MainActor
class 📱AppModel: NSObject, ObservableObject {
    @Published var widgetsModel = 🎛WidgetsModel()
    
    func saveAndReloadWidgetAndUpdateWCContext() {
        self.widgetsModel.save()
        WidgetCenter.shared.reloadAllTimelines()
        self.widgetsModel.updateWCContext()
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
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let ⓓata = message["ⓒontextWithNewText"] as? Data {
            if let ⓜodel = try? JSONDecoder().decode(🎛WidgetsModel.self, from: ⓓata) {
                self.widgetsModel = ⓜodel
                self.saveAndReloadWidgetAndUpdateWCContext()
            }
        }
    }
}
