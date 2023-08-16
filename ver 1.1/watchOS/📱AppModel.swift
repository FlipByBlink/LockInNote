import SwiftUI
import WatchConnectivity

@MainActor
class 📱AppModel: NSObject, ObservableObject {
    @Published var widgetsModel = 🎛WidgetsModel()
    @Published var reachable: Bool = true
    @Published var tasks: Set<WKRefreshBackgroundTask> = []
}

extension 📱AppModel {
    func applyReceivedWCContext(_ ⓒontext: [String: Any]) {
        Task { @MainActor in
            self.widgetsModel.receiveWCContext_saveData_reloadWidget(ⓒontext)
            self.tasks.forEach { $0.setTaskCompletedWithSnapshot(false) }
            self.tasks.removeAll()
        }
    }
    func updateReachablity(_ ⓢession: WCSession) {
        Task { @MainActor in
            self.reachable = ⓢession.isReachable
        }
    }
    func loadICloudTheFirstTime() {
        if 💾UserDefaults.notExists {
            if let ⓜodel = 💾ICloud.load() {
                self.widgetsModel = ⓜodel
                self.widgetsModel.saveData_reloadWidget()
            }
        }
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
                self.tasks.insert(ⓦcTask)
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
        self.updateReachablity(session)
    }
    //Optional
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        self.applyReceivedWCContext(applicationContext)
    }
    //Optional
    func sessionReachabilityDidChange(_ session: WCSession) {
        self.updateReachablity(session)
    }
}
