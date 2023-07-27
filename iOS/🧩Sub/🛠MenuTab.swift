import SwiftUI

struct 🛠MenuTab: View { // ⚙️
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ℹ️IconAndName()
                    ℹ️AppStoreLink()
                    NavigationLink {
                        List { ℹ️AboutAppContent() }
                            .navigationTitle(String(localized: "About App", table: "🌐AboutApp"))
                    } label: {
                        Label(String(localized: "About App", table: "🌐AboutApp"),
                              systemImage: "doc")
                    }
                }
                🛒InAppPurchaseMenuLink()
                🔗URLSchemeActionMenuLink()
            }
            .navigationTitle("Menu")
        }
    }
}
