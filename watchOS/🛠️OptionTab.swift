import SwiftUI

struct 🛠️OptionTab: View {
    var body: some View {
        List {
            NavigationLink("Option") {
                List {
                    Text(verbatim: "Palceholder")
                }
                .navigationTitle("Option")
            }
            ℹ️AboutAppLink()
        }
        .tag(🔖Tab.menu)
    }
}
