import SwiftUI
import WidgetKit
import WatchConnectivity

@MainActor
class 📱AppModel: NSObject, ObservableObject {
    @Published var widgetsModel = 🎛WidgetsModel()
    
    @Published var ⓡeachable: Bool = false
    @Published var ⓣasks: Set<WKRefreshBackgroundTask> = []
    
    func applyReceivedWCContext(_ ⓒontext: [String: Any]) {
        Task { @MainActor in
            self.widgetsModel.receiveWCContext(ⓒontext)
            WidgetCenter.shared.reloadAllTimelines()
            self.ⓣasks.forEach { $0.setTaskCompletedWithSnapshot(false) }
            self.ⓣasks.removeAll()
        }
    }
    
    func sendContextWithNewText() {
        guard let ⓓata = self.widgetsModel.asData else { return }
        WCSession.default.sendMessage(["ⓒontextWithNewText": ⓓata], replyHandler: nil)
    }
}

extension 📱AppModel: WKApplicationDelegate {
    func applicationDidFinishLaunching() {
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        for ⓣask in backgroundTasks {
            if let ⓦcTask = ⓣask as? WKWatchConnectivityRefreshBackgroundTask {
                self.ⓣasks.insert(ⓦcTask)
            } else {
                ⓣask.setTaskCompletedWithSnapshot(false)
            }
        }
    }
}

extension 📱AppModel: WCSessionDelegate {
    //Required
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        self.applyReceivedWCContext(session.receivedApplicationContext)
        Task { @MainActor in self.ⓡeachable = session.isReachable }
    }
    //Optional
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        self.applyReceivedWCContext(applicationContext)
    }
    func sessionReachabilityDidChange(_ session: WCSession) {
        Task { @MainActor in self.ⓡeachable = session.isReachable }
    }
}
