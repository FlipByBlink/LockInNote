import SwiftUI

struct 🪄Commands: Commands {
    @ObservedObject var app: 📱AppModel
    @Environment(\.openWindow) var openWindow
    var body: some Commands {
        CommandGroup(before: .appVisibility) {
            Button(String(localized: "In-App Purchase", table: "🌐AD&InAppPurchase")) { self.openWindow(id: "InAppPurchase") }
            Divider()
        }
        CommandGroup(replacing: .systemServices) { EmptyView() }
        CommandGroup(after: .newItem) {
            🪄SwitchNoteButton(self.app, .primary)
                .keyboardShortcut("1", modifiers: .command)
            🪄SwitchNoteButton(self.app, .secondary)
                .keyboardShortcut("2", modifiers: .command)
            🪄SwitchNoteButton(self.app, .tertiary)
                .keyboardShortcut("3", modifiers: .command)
            Divider()
            Button("Customize widget") { self.openWindow(id: "customize") }
                .keyboardShortcut(",", modifiers: [.command, .shift])
        }
        🪄ClearNoteCommand(self.app)
        CommandMenu("Action") { 🔗URLSchemeActionCommand(self.app) }
        CommandGroup(replacing: .help) { EmptyView() }
        CommandGroup(after: .help) {
            Link(String(localized: "Open AppStore page", table: "🌐AboutApp"), destination: 🗒️StaticInfo.appStoreProductURL)
            Link(String(localized: "Review on AppStore", table: "🌐AboutApp"), destination: 🗒️StaticInfo.appStoreUserReviewURL)
            Divider()
            Button(String(localized: "Description", table: "🌐AboutApp")) { self.openWindow(id: "Description") }
            Button(String(localized: "Privacy Policy", table: "🌐AboutApp")) { self.openWindow(id: "PrivacyPolicy") }
            Button(String(localized: "Version History", table: "🌐AboutApp")) { self.openWindow(id: "VersionHistory") }
            Divider()
            Button(String(localized: "Source code", table: "🌐AboutApp")) { self.openWindow(id: "SourceCode") }
            Button(String(localized: "Developer / Publisher", table: "🌐AboutApp")) { self.openWindow(id: "DeveloperPublisher") }
        }
    }
    init(_ app: 📱AppModel) {
        self.app = app
    }
}

private struct 🪄SwitchNoteButton: View {
    @ObservedObject var app: 📱AppModel
    var noteFamily: 📝NoteFamily
    @Environment(\.openWindow) var openWindow
    var body: some View {
        Button(self.app.note(self.noteFamily).title) {
            if self.app.target == self.noteFamily {
                if NSApplication.shared.keyWindow?.identifier?.rawValue == "note" {
                    Task {
                        self.app.playFeedback = true
                        try? await Task.sleep(for: .seconds(0.4))
                        self.app.playFeedback = false
                    }
                } else {
                    self.openWindow(id: "note")
                }
            } else {
                self.app.target = self.noteFamily
                self.openWindow(id: "note")
            }
        }
    }
    init(_ app: 📱AppModel, _ noteFamily: 📝NoteFamily) {
        self.app = app
        self.noteFamily = noteFamily
    }
}

private struct 🪄ClearNoteCommand: Commands {
    @ObservedObject var note: 📝NoteModel
    var body: some Commands {
        CommandGroup(before: .undoRedo) {
            Button("Clear this note") { self.note.text.removeAll() }
                .keyboardShortcut("d", modifiers: [.command, .shift])
                .disabled(self.note.text.isEmpty)
            Divider()
        }
    }
    init(_ ⓐpp: 📱AppModel) {
        self.note = ⓐpp.note(ⓐpp.target)
    }
}
