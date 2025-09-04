import SwiftUI

struct 🛠️PreventAutomaticKeyboardOption: View {
    @AppStorage("preventAutomaticKeyboard") var value: Bool = false
    var body: some View {
        Section {
            Toggle(isOn: self.$value) {
                Label("Prevent the keyboard from starting up automatically",
                      systemImage: "keyboard")
            }
        } footer: {
            Text("Not sync this option between devices")
        }
    }
}
