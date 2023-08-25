import SwiftUI

struct 🔧Settings: View {
    var body: some View {
        Form {
            Toggle(isOn: .constant(false)) { Label("Hide share button", systemImage: "square.and.arrow.up") }
        }
        .frame(minWidth: 300, minHeight: 100)
    }
}
