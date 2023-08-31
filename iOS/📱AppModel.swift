import SwiftUI

class 📱AppModel: ObservableObject {
    @Published var tab: 🔖Tab = .note(.primary)
    @Published var sheet: 💬Sheet? = nil
    @Published private(set) var preferTextFieldFocus: 📝NoteFamily? = nil
    let primaryNote: 📝NoteModel = .init(.primary)
    let secondaryNote: 📝NoteModel = .init(.secondary)
    let tertiaryNote: 📝NoteModel = .init(.tertiary)
    let inAppPurchaseModel: 🛒InAppPurchaseModel = .init(id: "LockInNote.adfree")
}

extension 📱AppModel {
    func handle(_ ⓦidgetURL: URL) {
        guard let ⓣarget = 📝NoteFamily.decode(ⓦidgetURL) else {
            assertionFailure("Failed url decode")
            return
        }
        switch self.sheet {
            case .ad: 
                return
            case .onboarding:
                self.sheet = nil
                self.tab = .note(ⓣarget)
            case .customize(let ⓒustomizingNote):
                guard ⓣarget != ⓒustomizingNote else { return }
                self.sheet = nil
            case .none:
                self.tab = .note(ⓣarget)
        }
        if !UserDefaults.standard.bool(forKey: "preventAutomaticKeyboard") {
            Task { @MainActor in
                try? await Task.sleep(for: .seconds(0.25))
                self.preferTextFieldFocus = ⓣarget
            }
        }
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    func completeFocusHandle() {
        self.preferTextFieldFocus = nil
    }
}
