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
