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
    func switchNote(_ ⓝoteFamily: 📝NoteFamily, _ ⓞpenWindow: OpenWindowAction) {
        if self.target == ⓝoteFamily {
            if NSApplication.shared.keyWindow?.identifier?.rawValue == "note" {
                self.playFeedback()
            } else {
                ⓞpenWindow(id: "note")
            }
        } else {
            self.target = ⓝoteFamily
            ⓞpenWindow(id: "note")
        }
    }
    func note(_ ⓕamily: 📝NoteFamily) -> 📝NoteModel {
        switch ⓕamily {
            case .primary: self.primaryNote
            case .secondary: self.secondaryNote
            case .tertiary: self.tertiaryNote
        }
    }
}

private extension 📱AppModel {
    private func showNoteWindow() {
        NSApplication.shared.windows
            .first { $0.identifier?.rawValue == "note" }?
            .makeKeyAndOrderFront(nil)
    }
    private func playFeedback() {
        Task {
            self.playingFeedback = true
            try? await Task.sleep(for: .seconds(0.4))
            self.playingFeedback = false
        }
    }
}
