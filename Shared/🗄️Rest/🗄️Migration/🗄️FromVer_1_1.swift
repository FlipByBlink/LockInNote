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

#if os(iOS)
extension 🗄️MigrationFromVer_1_1 {
    static func execute() {
        let ⓢources = 🎛WidgetsModel()
        📝NoteFamily.allCases.forEach {
            switch $0 {
                case .primary:
                    let ⓢource = ⓢources.rectangular
                    💾ICloud.save(.text, .primary, ⓢource.text)
                    💾ICloud.save(.empty_type, .primary, Self.convert(ⓢource.placeholder))
                    💾ICloud.save(.accessory_fontSize, .primary, ⓢource.fontSize)
                    💾ICloud.save(.accessory_fontWeight, .primary, Self.convert(ⓢource.fontWeight))
                    💾ICloud.save(.accessory_fontDesign, .primary, Self.convert(ⓢource.fontDesign))
                    💾ICloud.save(.accessory_italic, .primary, ⓢource.italic)
                    💾ICloud.save(.accessory_hierarchical, .primary, Self.convert(ⓢource.level))
                    💾ICloud.save(.accessory_multilineTextAlignment, .primary, Self.convert(ⓢource.multilineTextAlignment))
                case .secondary:
                    let ⓢource = ⓢources.circular
                    💾ICloud.save(.text, .secondary, ⓢource.text)
                    💾ICloud.save(.empty_type, .secondary, Self.convert(ⓢource.placeholder))
                    💾ICloud.save(.accessory_fontSize, .secondary, ⓢource.fontSize)
                    💾ICloud.save(.accessory_fontWeight, .secondary, Self.convert(ⓢource.fontWeight))
                    💾ICloud.save(.accessory_fontDesign, .secondary, Self.convert(ⓢource.fontDesign))
                    💾ICloud.save(.accessory_italic, .secondary, ⓢource.italic)
                    💾ICloud.save(.accessory_hierarchical, .secondary, Self.convert(ⓢource.level))
                    💾ICloud.save(.accessory_multilineTextAlignment, .secondary, Self.convert(ⓢource.multilineTextAlignment))
                    💾ICloud.save(.accessoryCircular_backgroundForIOS16WatchOS9, .secondary, ⓢource.background)
                case .tertiary:
                    let ⓢource = ⓢources.circular
                    💾ICloud.save(.text, .tertiary, ⓢource.text)
                    💾ICloud.save(.empty_type, .tertiary, Self.convert(ⓢource.placeholder))
            }
        }
        NSUbiquitousKeyValueStore.default.removeObject(forKey: "ⓦidgetsModel")
    }
    static func convert(_ ⓥalue: 🄿laceholder) -> 🎚️EmptyType {
        switch ⓥalue {
            case .squareAndPencil: .squareAndPencil
            case .ellipsis: .ellipsis
            case .pencil: .pencil
            case .nothing: .nothing
        }
    }
    static func convert(_ ⓥalue: 🅆eight) -> 🎚️FontWeight {
        switch ⓥalue {
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
    static func convert(_ ⓥalue: 🄳esign) -> 🎚️FontDesign {
        switch ⓥalue {
            case .default: .default
            case .serif: .serif
            case .rounded: .rounded
            case .monospaced: .monospaced
        }
    }
    static func convert(_ ⓥalue: 🄻evel) -> 🎚️Hierarchical {
        switch ⓥalue {
            case .primary: .primary
            case .secondary: .secondary
            case .tertiary: .tertiary
            case .quaternary: .quaternary
        }
    }
    static func convert(_ ⓥalue: 🄼ultilineTextAlignment) -> 🎚️MultilineTextAlignment {
        switch ⓥalue {
            case .leading: .leading
            case .center: .center
            case .trailing: .trailing
        }
    }
}
#endif
