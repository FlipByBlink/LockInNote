import SwiftUI

struct 📝NoteWindow: Scene {
    @ObservedObject var app: 📱AppModel
    var body: some Scene {
        Window("Note", id: "note") {
            ContentView()
        }
        .defaultSize(width: 390, height: 180)
        .commands { 🪄Commands(self.app) }
    }
    init(_ app: 📱AppModel) {
        self.app = app
    }
}
