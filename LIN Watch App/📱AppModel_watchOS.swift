import SwiftUI
import WidgetKit
import WatchConnectivity

@MainActor
class 📱AppModel: NSObject, ObservableObject {
    @Published var widgetsModel = 🎛WidgetsModel()
    
    @Published var ⓣasks: Set<WKRefreshBackgroundTask> = []
    
    func saveAndReloadWidgetAndUpdateWCContext() {
        self.widgetsModel.save()
        WidgetCenter.shared.reloadAllTimelines()
        self.widgetsModel.updateWCContext()
    }
    
    func applyReceivedWCContext(_ ⓒontext: [String: Any]) {
        Task { @MainActor in
            self.widgetsModel.receiveWCContext(ⓒontext)
            WidgetCenter.shared.reloadAllTimelines()
            self.ⓣasks.forEach { $0.setTaskCompletedWithSnapshot(false) }
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
        self.ⓣasks.forEach { ⓣask in
            switch ⓣask {
                case let ⓦatchConnectivityTask as WKWatchConnectivityRefreshBackgroundTask:
                    self.ⓣasks.insert(ⓦatchConnectivityTask)
                default:
                    ⓣask.setTaskCompletedWithSnapshot(false)
            }
        }
    }
}

extension 📱AppModel: WCSessionDelegate {
    //Required
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        self.applyReceivedWCContext(session.receivedApplicationContext)
    }
    //Optional
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        self.applyReceivedWCContext(applicationContext)
    }
}
