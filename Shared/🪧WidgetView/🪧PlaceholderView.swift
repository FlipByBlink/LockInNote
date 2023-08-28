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
                case .accessoryCircular, .accessoryRectangular:
                    Text(verbatim: "AAAAA")
                    Text(verbatim: "AAAAA")
                    Text(verbatim: "AAA")
                default:
                    Text(verbatim: "AAAAA")
                    Text(verbatim: "AAAAA")
                    Text(verbatim: "AAA")
            }
        }
        .minimumScaleFactor(0.4)
        .lineLimit(1)
        .redacted(reason: .placeholder)
        .modifier(🪧ContainerBackground())
    }
}
