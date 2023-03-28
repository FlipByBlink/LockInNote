import Foundation

enum 🔗WidgetLink {
    case rectangular, circular, inline
    var path: String {
        switch self {
            case .rectangular: return "example://Rectangular"
            case .circular: return "example://Circular"
            case .inline: return "example://Inline"
        }
    }
    var url: URL { URL(string: self.path)! }
}
