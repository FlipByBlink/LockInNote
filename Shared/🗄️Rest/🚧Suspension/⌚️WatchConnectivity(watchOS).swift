import WatchConnectivity
import WidgetKit

class 📱AppModel: NSObject, ObservableObject, WKApplicationDelegate {
    ========
    private var ⓣasks: Set<WKRefreshBackgroundTask> = []
    ========
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
        💾ICloud.synchronize()
    }
    //Optional
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        self.fetchFromIPhone()
    }
}

extension 📱AppModel {
    func pushToIPhone() {
        try? WCSession.default.updateApplicationContext(["pushedFromAppleWatch": Date.now])
    }
    func fetchFromIPhone() {
        Task { @MainActor in
            💾ICloud.synchronize()
            WidgetCenter.shared.reloadAllTimelines()
            self.ⓣasks.forEach { $0.setTaskCompletedWithSnapshot(false) }
            self.ⓣasks.removeAll()
        }
    }
}

struct PushToIPhone: ViewModifier {
    @EnvironmentObject var app: 📱AppModel
    @Environment(\.scenePhase) var scenePhase
    func body(content: Content) -> some View {
        content
            .onChange(of: scenePhase) {
                if $0 == .background { self.app.pushToIPhone() }
            }
    }
}
