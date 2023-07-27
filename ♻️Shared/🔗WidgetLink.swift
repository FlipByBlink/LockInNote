import Foundation

enum 🔗WidgetLink {
    case rectangular, circular, inline
    var path: String {
        switch self {
            case .rectangular: "example://Rectangular"
            case .circular: "example://Circular"
            case .inline: "example://Inline"
        }
    }
    var url: URL { URL(string: self.path)! }
}
