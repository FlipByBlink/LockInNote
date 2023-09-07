import SwiftUI

struct ℹ️InfoTab: View {
    var body: some View {
        NavigationStack {
            ℹ️AboutAppMenu()
        }
        .tag(🔖Tab.info)
    }
}
