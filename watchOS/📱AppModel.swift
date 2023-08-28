import SwiftUI

@MainActor
class 📱AppModel: NSObject, ObservableObject, WKApplicationDelegate {
    @Published var tab: 🔖Tab = .note(.primary)
    @Published var sheet: 💬Sheet? = nil
    let primaryNote: 📝NoteModel = .init(.primary)
    let secondaryNote: 📝NoteModel = .init(.secondary)
    let tertiaryNote: 📝NoteModel = .init(.tertiary)
}

extension 📱AppModel {
    func note(_ ⓕamily: 📝NoteFamily) -> 📝NoteModel {
        switch ⓕamily {
            case .primary: self.primaryNote
            case .secondary: self.secondaryNote
            case .tertiary: self.tertiaryNote
        }
    }
    func handle(_ ⓕamily: 📝NoteFamily, _ ⓦidgetURL: URL) throws {
        guard ⓦidgetURL == ⓕamily.widgetURL else { throw Self.HandleError.notTarget }
        guard let ⓣarget = 📝NoteFamily.decode(ⓦidgetURL) else { throw Self.HandleError.urlDecodeFailed }
        switch self.sheet {
            case .customize(let ⓒustomizingNote):
                guard ⓣarget != ⓒustomizingNote else { throw Self.HandleError.customizing }
                self.sheet = nil
            case .noteDetail:
                self.sheet = nil
            case .none:
                break
        }
        Task {
            try? await Task.sleep(for: .seconds(0.1))
            withAnimation { self.tab = .note(ⓣarget) }
        }
    }
    enum HandleError: Error {
        case notTarget, customizing, urlDecodeFailed
    }
}




//TODO: Work in progress
//import WatchConnectivity
//import WidgetKit
//
//class 📱AppModel: NSObject, ObservableObject, WKApplicationDelegate {
//    ========
//    private var ⓣasks: Set<WKRefreshBackgroundTask> = []
//    ========
//}
//
//extension 📱AppModel: WKApplicationDelegate {
//    func applicationDidFinishLaunching() {
//        if WCSession.isSupported() {
//            WCSession.default.delegate = self
//            WCSession.default.activate()
//        }
//    }
//    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
//        for ⓣask in backgroundTasks {
//            if let ⓦcTask = ⓣask as? WKWatchConnectivityRefreshBackgroundTask {
//                self.ⓣasks.insert(ⓦcTask)
//            } else {
//                ⓣask.setTaskCompletedWithSnapshot(false)
//            }
//        }
//    }
//}
//
//extension 📱AppModel: WCSessionDelegate {
//    //Required
//    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
//        💾ICloud.synchronize()
//    }
//    //Optional
//    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
//        self.fetchFromIPhone()
//    }
//}
//
//extension 📱AppModel {
//    func pushToIPhone() {
//        try? WCSession.default.updateApplicationContext(["pushedFromAppleWatch": Date.now])
//    }
//    func fetchFromIPhone() {
//        Task { @MainActor in
//            💾ICloud.synchronize()
//            WidgetCenter.shared.reloadAllTimelines()
//            self.ⓣasks.forEach { $0.setTaskCompletedWithSnapshot(false) }
//            self.ⓣasks.removeAll()
//        }
//    }
//}
//
//struct PushToIPhone: ViewModifier {
//    @EnvironmentObject var app: 📱AppModel
//    @Environment(\.scenePhase) var scenePhase
//    func body(content: Content) -> some View {
//        content
//            .onChange(of: scenePhase) {
//                if $0 == .background { self.app.pushToIPhone() }
//            }
//    }
//}
