enum 📝NoteProperty: CaseIterable {
    case text
    
    case title
    
    case fontWeight
    case fontDesign
    case italic
    case multilineTextAlignment
    
    //MARK: Empty icon
    case empty_type
    case empty_iconSize
    case empty_userText
    
    //MARK: WidgetFamily.systemSmall, .systemMedium, .systemLarge, .systemExtraLarge
    case system_appearanceMode
    case system_fontSize
    case system_hierarchical
    case system_padding
    case system_contentAlignment
    case system_textColor
    case system_backgroundColor
    case system_backgroundGradient
    case system_doubleSizeOnLargeWidget
    
    //MARK: WidgetFamily.accessoryRectangular, .accessoryCircular
    case accessory_fontSize
    case accessory_hierarchical
    case accessoryCircular_backgroundForIOS16AndWatchOS
}
