import SwiftUI
import WidgetKit
import WatchConnectivity

class 📱AppModel: NSObject, ObservableObject {
    @Published var widgetsModel = 🎛WidgetsModel()
    
    @Published var ⓣasks: Set<WKRefreshBackgroundTask> = []
    
    func saveDataAndReloadWidget() {
        self.widgetsModel.save()
        WidgetCenter.shared.reloadAllTimelines()
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
                case let ⓢnapshotTask as WKSnapshotRefreshBackgroundTask:
                    if !WCSession.default.hasContentPending {
                        self.ⓣasks.forEach { $0.setTaskCompletedWithSnapshot(false) }
                    }
                    ⓢnapshotTask.setTaskCompleted(restoredDefaultState: false,
                                                  estimatedSnapshotExpiration: .distantFuture,
                                                  userInfo: nil)
                default:
                    ⓣask.setTaskCompletedWithSnapshot(false)
            }
        }
    }
}

extension 📱AppModel: WCSessionDelegate {
    //Required
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //Do something
    }
    //Optional
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        Task { @MainActor in
            if let ⓜodel = 🎛WidgetsModel.decode(applicationContext) {
                self.widgetsModel = ⓜodel
            } else {
                assertionFailure()
            }
        }
    }
}
