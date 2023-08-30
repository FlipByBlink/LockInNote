import SwiftUI

struct ℹ️InfoTab: View {
    var body: some View {
        NavigationStack {
            List {
                🚧DebugMenu()
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
                💁HowToGuideSection()
            }
            .navigationTitle("Info")
        }
        .tag(🔖Tab.info)
        .tabItem { Label("Info", systemImage: "info") }
    }
}
