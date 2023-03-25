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

//appReview reject を受けて一旦 commentOut
//Section {
//    Text("If lock screen widgets don't update, please close this app or switch to another app.")
//} header: {
//    Text("Directions")
//}
