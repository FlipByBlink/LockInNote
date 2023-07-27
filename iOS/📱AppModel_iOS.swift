import SwiftUI
import WidgetKit
import WatchConnectivity

@MainActor
class 📱AppModel: NSObject, ObservableObject {
    @Published var widgetsModel = 🎛WidgetsModel()
    
    func applyReceivedWCMessage(_ ⓜessage: [String: Any]) {
        Task { @MainActor in
            self.widgetsModel.receiveWCMessageWithNewText(ⓜessage)
        }
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
        //Nothing to do
    }
    //Required
    func sessionDidBecomeInactive(_ session: WCSession) {
        //Nothing to do
    }
    //Required
    func sessionDidDeactivate(_ session: WCSession) {
        session.activate()
    }
    //Optional
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        self.applyReceivedWCMessage(message)
    }
}
