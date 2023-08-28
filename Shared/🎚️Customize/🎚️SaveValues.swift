import SwiftUI

struct 🎚️SaveValues: ViewModifier {
    @EnvironmentObject var note: 📝NoteModel
    func body(content: Content) -> some View {
        content
        //MARK: WidgetFamily.systemSmall, .systemMedium, .systemLarge
            .onChange(of: self.note.system_appearanceMode) { self.note.save(.system_appearanceMode, $0) }
            .onChange(of: self.note.system_fontSize) { self.note.save(.system_fontSize, $0) }
            .onChange(of: self.note.system_fontWeight) { self.note.save(.system_fontWeight, $0) }
            .onChange(of: self.note.system_fontDesign) { self.note.save(.system_fontDesign, $0) }
            .onChange(of: self.note.system_hierarchical) { self.note.save(.system_hierarchical, $0) }
            .onChange(of: self.note.system_multilineTextAlignment) { self.note.save(.system_multilineTextAlignment, $0) }
            .onChange(of: self.note.system_italic) { self.note.save(.system_italic, $0) }
            .onChange(of: self.note.system_padding) { self.note.save(.system_padding, $0) }
            .onChange(of: self.note.system_contentAlignment) { self.note.save(.system_contentAlignment, $0) }
            .onChange(of: self.note.system_textColor) { self.note.save(.system_textColor, 🎚️Color($0)) }
            .onChange(of: self.note.system_backgroundColor) { self.note.save(.system_backgroundColor, 🎚️Color($0)) }
            .onChange(of: self.note.system_backgroundGradient) { self.note.save(.system_backgroundGradient, $0) }
            .onChange(of: self.note.system_doubleSizeOnLargeWidget) { self.note.save(.system_doubleSizeOnLargeWidget, $0) }
        
        //MARK: WidgetFamily.accessoryInline, .accessoryCircular, .accessoryRectangular
            .onChange(of: self.note.accessory_fontSize) { self.note.save(.accessory_fontSize, $0) }
            .onChange(of: self.note.accessory_fontWeight) { self.note.save(.accessory_fontWeight, $0) }
            .onChange(of: self.note.accessory_fontDesign) { self.note.save(.accessory_fontDesign, $0) }
            .onChange(of: self.note.accessory_hierarchical) { self.note.save(.accessory_hierarchical, $0) }
            .onChange(of: self.note.accessory_multilineTextAlignment) { self.note.save(.accessory_multilineTextAlignment, $0) }
            .onChange(of: self.note.accessory_italic) { self.note.save(.accessory_italic, $0) }
            .onChange(of: self.note.accessoryCircular_backgroundForIOS16AndWatchOS) {
                self.note.save(.accessoryCircular_backgroundForIOS16AndWatchOS, $0)
            }
        
        //MARK: Empty content
            .onChange(of: self.note.empty_type) { self.note.save(.empty_type, $0) }
            .onChange(of: self.note.empty_iconSize) { self.note.save(.empty_iconSize, $0) }
            .onChange(of: self.note.empty_userText) { self.note.save(.empty_userText, $0) }
    }
}
