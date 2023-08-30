import SwiftUI

@MainActor
class 📱AppModel: NSObject, ObservableObject, UIApplicationDelegate {
    @Published var tab: 🔖Tab = .note(.primary)
    @Published var sheet: 💬Sheet? = nil
    let primaryNote: 📝NoteModel = .init(.primary)
    let secondaryNote: 📝NoteModel = .init(.secondary)
    let tertiaryNote: 📝NoteModel = .init(.tertiary)
    let inAppPurchaseModel: 🛒InAppPurchaseModel = .init(id: "LockInNote.adfree")
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
