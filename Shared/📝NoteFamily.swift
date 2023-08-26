import SwiftUI

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
            case .primary: .init(localized: "This is a note widget.")
            case .secondary: .init(localized: "This is a secondary widget.")
            case .tertiary: .init(localized: "This is a tertiary widget.")
        }
    }
    var presetTitle: String {
        switch self {
            case .primary: .init(localized: .init("presetTitle/primary", defaultValue: "Note"))
            case .secondary: .init(localized: .init("presetTitle/secondary", defaultValue: "Secondary"))
            case .tertiary: .init(localized: .init("presetTitle/tertiary", defaultValue: "Tertiary"))
        }
    }
    var presetTitleOnSystemUI: String {
        Self.primary.presetTitle
            .appending(self != .primary ? "(\(self.presetTitle))" : "")
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
