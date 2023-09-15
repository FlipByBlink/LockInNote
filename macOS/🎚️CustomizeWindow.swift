import SwiftUI

struct 🎚️CustomizeWindow: Scene {
    var body: some Scene {
        Window("Customize", id: "customize") {
            🎚️CustomizeMenu()
        }
        .defaultSize(width: 800, height: 900)
    }
}
