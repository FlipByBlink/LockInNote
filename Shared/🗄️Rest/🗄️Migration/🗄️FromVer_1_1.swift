import SwiftUI

enum 🗄️MigrationFromVer_1_1 {
    static func widgetKind(_ ⓝoteFamily: 📝NoteFamily) -> String {
        switch ⓝoteFamily {
            case .primary: "Rectangular"
            case .secondary: "Circular"
            case .tertiary: "Inline"
        }
    }
}
