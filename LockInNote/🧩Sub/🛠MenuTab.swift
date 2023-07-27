import SwiftUI

struct 🛠MenuTab: View { // ⚙️
    var body: some View {
        NavigationStack {
            List {
                ℹ️AboutAppLink(name: "LockInNote", subtitle: "App for iPhone / Apple Watch")
                📣ADMenuLink()
                🔗URLSchemeActionMenuLink()
            }
            .navigationTitle("Menu")
        }
    }
}
