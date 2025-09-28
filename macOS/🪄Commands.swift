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
            Group {
                Self.SwitchNoteButton(.primary)
                Self.SwitchNoteButton(.secondary)
                Self.SwitchNoteButton(.tertiary)
            }
            .environmentObject(self.app)
            Divider()
            Button("Customize widget") { self.openWindow(id: "customize") }
                .keyboardShortcut(",", modifiers: [.command, .shift])
        }
        Self.ClearNoteCommand(self.app)
        CommandMenu("Action") {
            🔗URLSchemeActionCommand()
                .environmentObject(self.app)
        }
        CommandGroup(replacing: .help) { EmptyView() }
        CommandGroup(after: .help) {
            Link(String(localized: "Open App Store page", table: "🌐AboutApp"), destination: 🗒️StaticInfo.appStoreProductURL)
            Link(String(localized: "Review on App Store", table: "🌐AboutApp"), destination: 🗒️StaticInfo.appStoreUserReviewURL)
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

private extension 🪄Commands {
    private struct SwitchNoteButton: View {
        @EnvironmentObject var app: 📱AppModel
        var noteFamily: 📝NoteFamily
        @Environment(\.openWindow) var openWindow
        var body: some View {
            Button(self.app.note(self.noteFamily).title) {
                self.app.switchNote(self.noteFamily, self.openWindow)
            }
            .keyboardShortcut(self.shortcutKey)
        }
        private var shortcutKey: KeyEquivalent {
            switch self.noteFamily {
                case .primary: "1"
                case .secondary: "2"
                case .tertiary: "3"
            }
        }
        init(_ noteFamily: 📝NoteFamily) {
            self.noteFamily = noteFamily
        }
    }
    private struct ClearNoteCommand: Commands {
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
}
