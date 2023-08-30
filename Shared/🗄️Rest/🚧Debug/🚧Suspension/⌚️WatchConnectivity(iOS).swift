import WatchConnectivity
import WidgetKit

extension 📱AppModel: UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
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
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        Task { @MainActor in
            💾ICloud.synchronize()
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
}

extension 📱AppModel {
    func pushToAppleWatch() {
        try? WCSession.default.updateApplicationContext(["pushedFromIPhone": Date.now])
    }
}

struct PushToAppleWatch: ViewModifier {
    @EnvironmentObject var app: 📱AppModel
    @Environment(\.scenePhase) var scenePhase
    func body(content: Content) -> some View {
        content
            .onChange(of: scenePhase) {
                if $0 == .background { self.app.pushToAppleWatch() }
            }
    }
}
