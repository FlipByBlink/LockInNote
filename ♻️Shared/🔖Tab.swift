import SwiftUI

enum 🔖Tab {
    case rectangularWidget, circularWidget, inlineWidget, menu
    mutating func handleURL(_ ⓤrl: URL) {
        switch ⓤrl.description {
            case "example://Rectangular": self = .rectangularWidget
            case "example://Circular": self = .circularWidget
            case "example://Inline": self = .inlineWidget
            default: print(ⓤrl); assertionFailure()
        }
    }
    var url: URL {
        switch self {
            case .rectangularWidget: return URL(string: "example://Rectangular")!
            case .circularWidget: return URL(string: "example://Circular")!
            case .inlineWidget: return URL(string: "example://Inline")!
            case .menu: assertionFailure(); return URL(string: "🐛")!
        }
    }
}

#if os(watchOS)
extension 🔖Tab {
    var navigationTitle: LocalizedStringKey {
        switch self {
            case .rectangularWidget: return "Rectangular"
            case .circularWidget: return "Circular"
            case .inlineWidget: return "Inline"
            case .menu: return "🐛"
        }
    }
}
#endif
