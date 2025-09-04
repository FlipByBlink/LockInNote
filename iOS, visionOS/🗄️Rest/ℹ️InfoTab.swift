import SwiftUI

struct ℹ️InfoTab: View {
    var body: some View {
        NavigationStack {
            List {
#if os(visionOS)
                🛠️PreventAutomaticKeyboardOption()
#endif
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
            .navigationTitle(Self.title)
            .navigationBarTitleDisplayMode(.inline)
            .modifier(🚧DebugMenu())
        }
        .tag(🔖Tab.info)
        .tabItem { Label(Self.title, systemImage: "info") }
    }
}

private extension ℹ️InfoTab {
    static var title: LocalizedStringResource {
#if os(iOS)
        "Info"
#elseif os(visionOS)
        "Menu"
#endif
    }
}
