enum 📝NoteProperty: CaseIterable {
    case text
    case title
    
    //MARK: WidgetFamily.systemSmall, .systemMedium, .systemLarge, .systemExtraLarge
    case system_appearanceMode
    case system_fontSize
    case system_fontWeight
    case system_fontDesign
    case system_hierarchical
    case system_multilineTextAlignment
    case system_italic
    case system_padding
    case system_contentAlignment
    case system_textColor
    case system_backgroundColor
    case system_backgroundGradient
    case system_doubleSizeOnLargeWidget
    
    //MARK: WidgetFamily.accessoryRectangular, .accessoryCircular
    case accessory_fontSize
    case accessory_fontWeight
    case accessory_fontDesign
    case accessory_hierarchical
    case accessory_multilineTextAlignment
    case accessory_italic
    case accessoryCircular_backgroundForIOS16AndWatchOS
    
    //MARK: Empty content
    case empty_type
    case empty_userText
}
