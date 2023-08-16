import SwiftUI

@MainActor
class 📱AppModel: NSObject, ObservableObject {
    @Published var target: 📝NoteFamily = .primary
    @Published var requestToOpenNote: Bool = false
    @Published var sheet: 💬Sheet? = nil
    @Published var playFeedback: Bool = false
    var primaryNote: 📝NoteModel = .init(.primary)
    var secondaryNote: 📝NoteModel = .init(.secondary)
    var tertiaryNote: 📝NoteModel = .init(.tertiary)
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
            self.requestToOpenNote = true
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
}
