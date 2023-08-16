import SwiftUI

enum 🎚️AppearanceMode: Codable, CaseIterable, Identifiable {
    case standard, color
    var id: Self { self }
    var label: LocalizedStringKey {
        switch self {
            case .standard: "Standard"
            case .color: "Color"
        }
    }
}

enum 🎚️FontWeight: Codable, CaseIterable, Identifiable {
    case ultraLight, thin, light, regular, medium, semibold, bold, heavy, black
    var id: Self { self }
    var value: Font.Weight {
        switch self {
            case .ultraLight: .ultraLight
            case .thin: .thin
            case .light: .light
            case .regular: .regular
            case .medium: .medium
            case .semibold: .semibold
            case .bold: .bold
            case .heavy: .heavy
            case .black: .black
        }
    }
    var label: LocalizedStringKey { .init(String(describing: self)) }
}

enum 🎚️FontDesign: Codable, CaseIterable, Identifiable {
    case `default`, serif, rounded, monospaced
    var id: Self { self }
    var value: Font.Design {
        switch self {
            case .default: .default
            case .serif: .serif
            case .rounded: .rounded
            case .monospaced: .monospaced
        }
    }
    var label: LocalizedStringKey { .init(String(describing: self)) }
}

enum 🎚️Hierarchical: Codable, CaseIterable, Identifiable {
    case primary, secondary, tertiary, quaternary
    var id: Self { self }
    var value: HierarchicalShapeStyle {
        switch self {
            case .primary: .primary
            case .secondary: .secondary
            case .tertiary: .tertiary
            case .quaternary: .quaternary
        }
    }
    var label: LocalizedStringKey { .init(String(describing: self)) }
}

struct 🎚️Color: Codable {
    var r, g, b: Double
    var swiftUIColor: Color { .init(red: self.r, green: self.g, blue: self.b) }
    init(_ ⓢwiftUIColor: Color) {
        if let ⓒolor = ⓢwiftUIColor.cgColor?.components {
            self.r = Double(ⓒolor[0])
            self.g = Double(ⓒolor[1])
            self.b = Double(ⓒolor[2])
        } else {
            (self.r, self.g, self.b) = (0, 0, 0)
        }
    }
}

enum 🎚️MultilineTextAlignment: Codable, CaseIterable, Identifiable {
    case leading, center, trailing
    var id: Self { self }
    var value: TextAlignment {
        switch self {
            case .leading: .leading
            case .center: .center
            case .trailing: .trailing
        }
    }
    var icon: String {
        switch self {
            case .leading: "text.justify.leading"
            case .center: "text.aligncenter"
            case .trailing: "text.justify.trailing"
        }
    }
    var label: LocalizedStringKey { .init(String(describing: self)) }
}

enum 🎚️ContentAlignment: Codable, CaseIterable, Identifiable {
    case topLeading, top, topTrailing,
         leading, center, trailing,
         bottomLeading, bottom, bottomTrailing
    var id: Self { self }
    var value: Alignment {
        switch self {
            case .topLeading: .topLeading
            case .top: .top
            case .topTrailing: .topTrailing
            case .leading: .leading
            case .center: .center
            case .trailing: .trailing
            case .bottomLeading: .bottomLeading
            case .bottom: .bottom
            case .bottomTrailing: .bottomTrailing
        }
    }
    var label: LocalizedStringKey { .init(String(describing: self)) }
}

enum 🎚️EmptyType: Codable, CaseIterable, Identifiable {
    case squareAndPencil, ellipsis, pencil, userText, nothing
    var id: Self { self }
    var icon: String {
        switch self {
            case .squareAndPencil: "square.and.pencil"
            case .ellipsis: "ellipsis"
            case .pencil: "pencil"
            case .userText, .nothing: "ladybug"
        }
    }
    var label: LocalizedStringKey {
        switch self {
            case .squareAndPencil: "Square and pencil"
            case .ellipsis: "Ellipsis"
            case .pencil: "Pencil"
            case .userText: "User text"
            case .nothing: "(Nothing)"
        }
    }
}
