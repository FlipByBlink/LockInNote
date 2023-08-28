import SwiftUI

struct ℹ️InfoTab: View {
    var body: some View {
        List {
            ℹ️AboutAppLink()
        }
        .tag(🔖Tab.info)
    }
}
