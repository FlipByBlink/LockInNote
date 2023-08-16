import Foundation

enum 📝NoteFamily {
    case primary, secondary, tertiary
}

extension 📝NoteFamily: Identifiable, CaseIterable {
    var id: Self { self }
    var widgetPath: String { "example://\(self)" }
    var widgetURL: URL { .init(string: self.widgetPath)! }
    static func decode(_ ⓤrl: URL) -> Self? {
        switch ⓤrl {
            case Self.primary.widgetURL: .primary
            case Self.secondary.widgetURL: .secondary
            case Self.tertiary.widgetURL: .tertiary
            default: nil
        }
    }
    var widgetDescription: String {
        switch self {
            case .primary: "This is a note widget."
            case .secondary: "This is a secondary widget."
            case .tertiary: "This is a tertiary widget."
        }
    }
    var presetTitle: String {
        switch self {
            case .primary: "Note"
            case .secondary: "Secondary"
            case .tertiary: "Tertiary"
        }
    }
    func loadTitle() -> String {
        do {
            return try 💾ICloud.load(.title, self)
        } catch 💾ICloud.LoadError.noData {
            return self.presetTitle
        } catch {
            assertionFailure()
            return self.presetTitle
        }
    }
}
