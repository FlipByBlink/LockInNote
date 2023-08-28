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
    static func execute(_ ⓝoteModel: 📝NoteModel) {
        switch ⓝoteModel.family {
            case .primary:
                if let ⓢource = 🎛RectangularWidgetModel.load() {
                    ⓝoteModel.text = ⓢource.text
                    ⓝoteModel.empty_type = Self.convert(ⓢource.placeholder)
                    ⓝoteModel.accessory_fontSize = ⓢource.fontSize
                    ⓝoteModel.accessory_fontWeight = Self.convert(ⓢource.fontWeight)
                    ⓝoteModel.accessory_fontDesign = Self.convert(ⓢource.fontDesign)
                    ⓝoteModel.accessory_italic = ⓢource.italic
                    ⓝoteModel.accessory_hierarchical = Self.convert(ⓢource.level)
                    ⓝoteModel.accessory_multilineTextAlignment = Self.convert(ⓢource.multilineTextAlignment)
                }
            case .secondary:
                if let ⓢource = 🎛CircularWidgetModel.load() {
                    ⓝoteModel.text = ⓢource.text
                    //ⓝoteModel.backgroundForIOS16Circular = ⓢource.background
                    ⓝoteModel.empty_type = Self.convert(ⓢource.placeholder)
                    ⓝoteModel.accessory_fontSize = ⓢource.fontSize
                    ⓝoteModel.accessory_fontWeight = Self.convert(ⓢource.fontWeight)
                    ⓝoteModel.accessory_fontDesign = Self.convert(ⓢource.fontDesign)
                    ⓝoteModel.accessory_italic = ⓢource.italic
                    ⓝoteModel.accessory_hierarchical = Self.convert(ⓢource.level)
                    ⓝoteModel.accessory_multilineTextAlignment = Self.convert(ⓢource.multilineTextAlignment)
                }
            case .tertiary:
                if let ⓢource = 🎛InlineWidgetModel.load() {
                    ⓝoteModel.text = ⓢource.text
                    ⓝoteModel.empty_type = Self.convert(ⓢource.placeholder)
                }
        }
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
    static func clearData() {
        NSUbiquitousKeyValueStore.default.removeObject(forKey: "ⓦidgetsModel")
    }
}
#endif
