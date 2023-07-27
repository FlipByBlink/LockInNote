import SwiftUI

enum 🔖Tab {
    case rectangularWidget, circularWidget, inlineWidget, guide, menu
    mutating func handleURL(_ ⓤrl: URL) {
        switch ⓤrl {
            case 🔗WidgetLink.rectangular.url: self = .rectangularWidget
            case 🔗WidgetLink.circular.url: self = .circularWidget
            case 🔗WidgetLink.inline.url: self = .inlineWidget
            default: print(ⓤrl); assertionFailure()
        }
    }
}

#if os(watchOS)
extension 🔖Tab {
    var navigationTitle: LocalizedStringKey {
        switch self {
            case .rectangularWidget: "Rectangular"
            case .circularWidget: "Circular"
            case .inlineWidget: "Inline"
            default: "🐛"
        }
    }
}
#endif
