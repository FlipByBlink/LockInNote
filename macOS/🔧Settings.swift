import SwiftUI

struct 🔧Settings: Scene {
    var body: some Scene {
        Settings {
            Form {
                Toggle(isOn: .constant(false)) { Label("Hide share button", systemImage: "square.and.arrow.up") }
            }
            .frame(minWidth: 300, minHeight: 100)
        }
    }
}
