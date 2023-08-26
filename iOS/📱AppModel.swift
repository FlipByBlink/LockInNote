import SwiftUI

@MainActor
class 📱AppModel: NSObject, ObservableObject {
    @Published var tab: 🔖Tab = .note(.primary)
    @Published var sheet: 💬Sheet? = nil
    let primaryNote: 📝NoteModel = .init(.primary)
    let secondaryNote: 📝NoteModel = .init(.secondary)
    let tertiaryNote: 📝NoteModel = .init(.tertiary)
}

extension 📱AppModel {
    func handleTab(_ ⓕamily: 📝NoteFamily, _ ⓦidgetURL: URL) throws {
        guard ⓦidgetURL == ⓕamily.widgetURL else { throw Self.HandleError.notTarget }
        guard let ⓣarget = 📝NoteFamily.decode(ⓦidgetURL) else { throw Self.HandleError.urlDecodeFailed }
        switch self.sheet {
            case .ad, .onboarding:
                throw Self.HandleError.presentedSheet
            case .customize(let ⓒustomizingNote):
                guard ⓣarget != ⓒustomizingNote else { throw Self.HandleError.customizing }
                self.sheet = nil
                self.tab = .note(ⓣarget)
            case .none:
                self.tab = .note(ⓣarget)
        }
    }
    enum HandleError: Error {
        case notTarget, customizing, urlDecodeFailed, presentedSheet
    }
}




//import WatchConnectivity
//import WidgetKit

extension 📱AppModel: UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        if WCSession.isSupported() {
//            WCSession.default.delegate = self
//            WCSession.default.activate()
//        }
        return true
    }
}

//extension 📱AppModel: WCSessionDelegate {
//    //Required
//    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
//        //Nothing to do
//    }
//    //Required
//    func sessionDidBecomeInactive(_ session: WCSession) {
//        //Nothing to do
//    }
//    //Required
//    func sessionDidDeactivate(_ session: WCSession) {
//        session.activate()
//    }
//    //Optional
//    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
//        Task { @MainActor in
//            💾ICloud.synchronize()
//            WidgetCenter.shared.reloadAllTimelines()
//        }
//    }
//}
