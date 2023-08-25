import SwiftUI

struct 🔧Settings: View {
    var body: some View {
        Form {
            Toggle(isOn: .constant(false)) { Label("Hide share button", systemImage: "square.and.arrow.up") }
            Toggle(isOn: .constant(false)) {
                Label {
                    Text("Monospaced font in app")
                        .monospaced()
                } icon: {
                    Image(systemName: "space")
                }
            }
        }
        .frame(minWidth: 300, minHeight: 100)
    }
}
