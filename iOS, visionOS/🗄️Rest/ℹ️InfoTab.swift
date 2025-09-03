import SwiftUI

struct ℹ️InfoTab: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
#if os(iOS)
                    ℹ️IconAndName()
#endif
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
            .navigationBarTitleDisplayMode(.inline)
            .modifier(🚧DebugMenu())
        }
        .tag(🔖Tab.info)
        .tabItem { Label("Info", systemImage: "info") }
    }
}
