import SwiftUI

struct 🛠️OptionTab: View {
    var body: some View {
        NavigationStack {
            List {
#if !os(visionOS)
                🛒InAppPurchaseMenuLink()
#endif
                Self.PreventAutomaticKeyboardOption()
                🔗URLSchemeActionMenuLink()
            }
            .navigationTitle("Option")
        }
        .tag(🔖Tab.option)
        .tabItem { Label("Option", systemImage: "gearshape") }
    }
}

private extension 🛠️OptionTab {
    private struct PreventAutomaticKeyboardOption: View {
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
}
