import SwiftUI

struct 🎚️CustomizeWindow: Scene {
    @ObservedObject var app: 📱AppModel
    var body: some Scene {
        Window("Customize", id: "customize") {
            🎚️CustomizeMenu()
                .modifier(📋AddNoteToEnvironment())
        }
        .defaultSize(width: 800, height: 900)
        .defaultPosition(.bottomTrailing)
    }
    init(_ app: 📱AppModel) {
        self.app = app
    }
}
