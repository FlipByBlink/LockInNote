import SwiftUI

struct 🛠️OptionTab: View {
    var body: some View {
#if os(iOS)
        NavigationStack {
            List {
                🛒InAppPurchaseMenuLink()
                🛠️PreventAutomaticKeyboardOption()
                🔗URLSchemeActionMenuLink()
            }
            .navigationTitle("Option")
        }
        .tag(🔖Tab.option)
        .tabItem { Label("Option", systemImage: "gearshape") }
#elseif os(visionOS)
        EmptyView()
#endif
    }
}
