import SwiftUI

struct 🎚️DoubleSizeOnLargeWidgetMenuLink: View {
    var body: some View {
        NavigationLink {
            List { 🎚️DoubleSizeOnLargeWidgetToggle() }
                .navigationTitle("More")
        } label: {
            Label("More", systemImage: "ellipsis")
        }
    }
}
