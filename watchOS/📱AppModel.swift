import SwiftUI

class 📱AppModel: ObservableObject {
    @Published var tab: 🔖Tab = .note(.primary)
    @Published var sheet: 💬Sheet? = nil
    let primaryNote: 📝NoteModel = .init(.primary)
    let secondaryNote: 📝NoteModel = .init(.secondary)
    let tertiaryNote: 📝NoteModel = .init(.tertiary)
}

extension 📱AppModel {
    func handle(_ ⓦidgetURL: URL) {
        guard let ⓣarget = 📝NoteFamily.decode(ⓦidgetURL) else {
            assertionFailure("Failed url decode")
            return
        }
        switch self.sheet {
            case .customize(let ⓒustomizingNote):
                guard ⓣarget != ⓒustomizingNote else { return }
                self.sheet = nil
            case .noteDetail:
                self.sheet = nil
            case .none:
                break
        }
        Task { @MainActor in
            try? await Task.sleep(for: .seconds(0.1))
            withAnimation { self.tab = .note(ⓣarget) }
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
