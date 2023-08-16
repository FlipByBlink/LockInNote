import SwiftUI

struct 🛠️OptionTab: View {
    var body: some View {
        List {
            NavigationLink("Option") {
                List {
                    Toggle("Toggle", isOn: .constant(false))
                }
                .navigationTitle("Option")
            }
            NavigationLink("About") {
                Text("Placeholder")
                    .navigationTitle("About")
            }
        }
    }
}
