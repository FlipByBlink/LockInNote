import SwiftUI

@MainActor
class 📱AppModel: NSObject, ObservableObject {
    @Published var target: 📝NoteFamily = .primary
//    @Published var requestToOpenNote: Bool = false TODO: 削除
    @Published var sheet: 💬Sheet? = nil
    @Published private(set) var playingFeedback: Bool = false
    let primaryNote: 📝NoteModel = .init(.primary)
    let secondaryNote: 📝NoteModel = .init(.secondary)
    let tertiaryNote: 📝NoteModel = .init(.tertiary)
    let inAppPurchaseModel: 🛒InAppPurchaseModel = .init(id: "LockInNote.adfree")
}

extension 📱AppModel: NSApplicationDelegate {
    func application(_ application: NSApplication, open urls: [URL]) {
        do {
            guard let ⓤrl = urls.first else { throw Self.OpenURLError.noURL }
            guard self.sheet != .ad else { throw Self.OpenURLError.presentedAD }
            guard let ⓣarget = 📝NoteFamily.decode(ⓤrl) else {
                throw Self.OpenURLError.urlDecodeFailed
            }
            self.target = ⓣarget
            self.showNoteWindow()
            if self.inAppPurchaseModel.checkToShowADSheet() { self.sheet = .ad }
        } catch {
            print("🚨", error, error.localizedDescription)
        }
    }
    enum OpenURLError: Error {
        case noURL, urlDecodeFailed, presentedAD
    }
}

extension 📱AppModel {
    func note(_ ⓕamily: 📝NoteFamily) -> 📝NoteModel {
        switch ⓕamily {
            case .primary: self.primaryNote
            case .secondary: self.secondaryNote
            case .tertiary: self.tertiaryNote
        }
    }
    func playFeedback() {
        Task {
            self.playingFeedback = true
            try? await Task.sleep(for: .seconds(0.4))
            self.playingFeedback = false
        }
    }
}

private extension 📱AppModel {
    private func showNoteWindow() {
        NSApplication.shared.windows
            .first { $0.identifier?.rawValue == "note" }?
            .makeKeyAndOrderFront(nil)
    }
}
