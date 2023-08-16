import SwiftUI

struct 🔧Settings: View {
    var body: some View {
        TabView {
//            🔗URLSchemeActionMenu()
//                .tabItem { Label("URL Scheme Action", systemImage: "command") }
            Text("2")
                .tabItem { Label("2", systemImage: "2.circle") }
        }
        .frame(minWidth: 400, minHeight: 500)
    }
}
