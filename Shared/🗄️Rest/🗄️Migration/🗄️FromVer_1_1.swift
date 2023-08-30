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

#if os(iOS) || os(watchOS)
extension 🗄️MigrationFromVer_1_1 {
    static func execute() {
        guard !NSUbiquitousKeyValueStore.default.bool(forKey: "ⓒompletedMigrationFromVer_1_1") else { return }
        guard let ⓢources = 💾ICloudVer_1_1.load() else { return }
        📝NoteFamily.allCases.forEach {
            switch $0 {
                case .primary:
                    let ⓢource = ⓢources.rectangular
                    💾ICloud.save(.text, .primary, ⓢource.text)
                    💾ICloud.save(.empty_type, .primary, Self.convert(ⓢource.placeholder))
                    💾ICloud.save(.accessory_fontSize, .primary, ⓢource.fontSize)
                    💾ICloud.save(.fontWeight, .primary, Self.convert(ⓢource.fontWeight))
                    💾ICloud.save(.fontDesign, .primary, Self.convert(ⓢource.fontDesign))
                    💾ICloud.save(.italic, .primary, ⓢource.italic)
                    💾ICloud.save(.accessory_hierarchical, .primary, Self.convert(ⓢource.level))
                    💾ICloud.save(.multilineTextAlignment, .primary, Self.convert(ⓢource.multilineTextAlignment))
                case .secondary:
                    let ⓢource = ⓢources.circular
                    💾ICloud.save(.text, .secondary, ⓢource.text)
                    💾ICloud.save(.empty_type, .secondary, Self.convert(ⓢource.placeholder))
                    💾ICloud.save(.accessory_fontSize, .secondary, ⓢource.fontSize)
                    💾ICloud.save(.fontWeight, .secondary, Self.convert(ⓢource.fontWeight))
                    💾ICloud.save(.fontDesign, .secondary, Self.convert(ⓢource.fontDesign))
                    💾ICloud.save(.italic, .secondary, ⓢource.italic)
                    💾ICloud.save(.accessory_hierarchical, .secondary, Self.convert(ⓢource.level))
                    💾ICloud.save(.multilineTextAlignment, .secondary, Self.convert(ⓢource.multilineTextAlignment))
                    💾ICloud.save(.accessoryCircular_backgroundForIOS16AndWatchOS, .secondary, ⓢource.background)
                case .tertiary:
                    let ⓢource = ⓢources.circular
                    💾ICloud.save(.text, .tertiary, ⓢource.text)
                    💾ICloud.save(.empty_type, .tertiary, Self.convert(ⓢource.placeholder))
            }
        }
        NSUbiquitousKeyValueStore.default.set(true, forKey: "ⓒompletedMigrationFromVer_1_1")
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
