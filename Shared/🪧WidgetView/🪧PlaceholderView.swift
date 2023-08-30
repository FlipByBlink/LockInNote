import SwiftUI

struct 🪧PlaceholderView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var body: some View {
        VStack(alignment: .leading) {
            switch self.widgetFamily {
                case .systemSmall, .systemMedium, .systemLarge, .systemExtraLarge:
                    Group {
                        Text(verbatim: "AAAAAAAAA")
                        Text(verbatim: "AAAAAAAAA")
                        Text(verbatim: "AAAAAAAAA")
                        Text(verbatim: "AAAAA")
                    }
                    .font(.title3)
                case .accessoryCircular:
                    Text(verbatim: "AAAAA")
                    Text(verbatim: "AAAAA")
                    Text(verbatim: "AAA")
                case .accessoryRectangular:
                    Text(verbatim: "AAAAAAAAAA")
                    Text(verbatim: "AAAAAAAAAA")
                    Text(verbatim: "AAAAA")
                default:
                    Text(verbatim: "AAAAA")
                    Text(verbatim: "AAAAA")
                    Text(verbatim: "AAA")
            }
        }
        .font(.subheadline)
        .minimumScaleFactor(0.4)
        .lineLimit(1)
        .redacted(reason: .placeholder)
        .modifier(🪧ContainerBackground())
    }
}
