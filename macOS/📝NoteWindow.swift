import SwiftUI

struct 📝NoteWindow: Scene {
    @ObservedObject var app: 📱AppModel
    @Environment(\.openWindow) var openWindow
    var body: some Scene {
        Window("Note", id: "note") {
            ContentView()
        }
        .defaultSize(width: 440, height: 200)
        .commands { 🪄Commands(self.app) }
        .onChange(of: self.app.requestToOpenNote) {
            if $0 {
                self.openWindow(id: "note")
                self.app.requestToOpenNote = false
            }
        }
    }
    init(_ app: 📱AppModel) {
        self.app = app
    }
}
