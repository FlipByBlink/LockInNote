import SwiftUI

struct 🪧PlaceholderView : View {
    var body: some View {
        VStack(alignment: .leading) {
            Text(verbatim: "AAAAAAAAAAAA")
            Text(verbatim: "AAAAAAAAAAAA")
            Text(verbatim: "AAAAAAAAAAAA")
            Text(verbatim: "AAAAAAA")
        }
        .font(.title3)
        .redacted(reason: .placeholder)
        .minimumScaleFactor(0.6)
        .modifier(🪧ContainerBackground())
    }
}
