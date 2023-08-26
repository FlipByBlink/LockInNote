import SwiftUI
import WidgetKit

class 📝NoteModel: ObservableObject {
    var family: 📝NoteFamily
    @Published var title: String
    @Published var text: String = ""
    
    //MARK: WidgetFamily.systemSmall, .systemMedium, .systemLarge, .systemExtraLarge
    @Published var system_appearanceMode: 🎚️AppearanceMode = .standard
    @Published var system_fontSize: Int = 20
    @Published var system_fontWeight: 🎚️FontWeight = .regular
    @Published var system_fontDesign: 🎚️FontDesign = .default
    @Published var system_hierarchical: 🎚️Hierarchical = .primary
    @Published var system_multilineTextAlignment: 🎚️MultilineTextAlignment = .center
    @Published var system_italic: Bool = false
    @Published var system_padding: Int = 12
    @Published var system_contentAlignment: 🎚️ContentAlignment = .center
    @Published var system_textColor: Color = .black
    @Published var system_backgroundColor: Color = .white
    @Published var system_backgroundGradient: Bool = false
    @Published var system_doubleSizeOnLargeWidget: Bool = false
    
    //MARK: WidgetFamily.accessoryInline, .accessoryCircular, .accessoryRectangular
    @Published var accessory_fontSize: Int = 12
    @Published var accessory_fontWeight: 🎚️FontWeight = .regular
    @Published var accessory_fontDesign: 🎚️FontDesign = .default
    @Published var accessory_hierarchical: 🎚️Hierarchical = .primary
    @Published var accessory_multilineTextAlignment: 🎚️MultilineTextAlignment = .center
    @Published var accessory_italic: Bool = false
    
    @Published var empty_type: 🎚️EmptyType = .squareAndPencil
    @Published var empty_userText: String = ""
    
    init(_ ⓝoteFamily: 📝NoteFamily, observeChange ⓞbserveChange: Bool = true) {
        self.family = ⓝoteFamily
        self.title = self.family.loadTitle()
        self.presetValues()
        📝NoteProperty.allCases.forEach { self.loadICloud($0) }
        if ⓞbserveChange {
            💾ICloud.addObserver(self, #selector(self.iCloudDidChangeExternally(_:)))
        }
    }
}

extension 📝NoteModel {
    func save(_ ⓟroperty: 📝NoteProperty, _ ⓥalue: some Codable) {
        💾ICloud.save(ⓟroperty, self.family, ⓥalue)
        WidgetCenter.shared.reloadAllTimelines()
    }
    @objc func iCloudDidChangeExternally(_ ⓝotification: Notification) {
        guard let ⓒhangedKeys = ⓝotification.userInfo?["NSUbiquitousKeyValueStoreChangedKeysKey"] as? [String] else {
            return
        }
        Task { @MainActor in
            ⓒhangedKeys.forEach {
                if let ⓒhangedProperty = 💾ICloud.decodeKey($0, self.family) {
                    self.loadICloud(ⓒhangedProperty)
                }
            }
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
    func loadICloud(_ ⓟroperty: 📝NoteProperty) {
        do {
            switch ⓟroperty {
                case .text: self.text = try 💾ICloud.load(ⓟroperty, self.family)
                case .title: self.title = try 💾ICloud.load(ⓟroperty, self.family)
                case .system_appearanceMode: self.system_appearanceMode = try 💾ICloud.load(ⓟroperty, self.family)
                case .system_fontSize: self.system_fontSize = try 💾ICloud.load(ⓟroperty, self.family)
                case .system_fontWeight: self.system_fontWeight = try 💾ICloud.load(ⓟroperty, self.family)
                case .system_fontDesign: self.system_fontDesign = try 💾ICloud.load(ⓟroperty, self.family)
                case .system_hierarchical: self.system_hierarchical = try 💾ICloud.load(ⓟroperty, self.family)
                case .system_multilineTextAlignment: self.system_multilineTextAlignment = try 💾ICloud.load(ⓟroperty, self.family)
                case .system_italic: self.system_italic = try 💾ICloud.load(ⓟroperty, self.family)
                case .system_padding: self.system_padding = try 💾ICloud.load(ⓟroperty, self.family)
                case .system_contentAlignment: self.system_contentAlignment = try 💾ICloud.load(ⓟroperty, self.family)
                case .system_textColor: self.system_textColor = (try 💾ICloud.load(ⓟroperty, self.family) as 🎚️Color).swiftUIColor
                case .system_backgroundColor: self.system_backgroundColor = (try 💾ICloud.load(ⓟroperty, self.family) as 🎚️Color).swiftUIColor
                case .system_backgroundGradient: self.system_backgroundGradient = try 💾ICloud.load(ⓟroperty, self.family)
                case .accessory_fontSize: self.accessory_fontSize = try 💾ICloud.load(ⓟroperty, self.family)
                case .accessory_fontWeight: self.accessory_fontWeight = try 💾ICloud.load(ⓟroperty, self.family)
                case .accessory_fontDesign: self.accessory_fontDesign = try 💾ICloud.load(ⓟroperty, self.family)
                case .accessory_hierarchical: self.accessory_hierarchical = try 💾ICloud.load(ⓟroperty, self.family)
                case .accessory_multilineTextAlignment: self.accessory_multilineTextAlignment = try 💾ICloud.load(ⓟroperty, self.family)
                case .accessory_italic: self.accessory_italic = try 💾ICloud.load(ⓟroperty, self.family)
                case .empty_type: self.empty_type = try 💾ICloud.load(ⓟroperty, self.family)
                case .empty_userText: self.empty_userText = try 💾ICloud.load(ⓟroperty, self.family)
                case .system_doubleSizeOnLargeWidget: self.system_doubleSizeOnLargeWidget = try 💾ICloud.load(ⓟroperty, self.family)
            }
        } catch 💾ICloud.LoadError.noData {
            return
        } catch {
            print(error, error.localizedDescription); assertionFailure()
        }
    }
    private func presetValues() {
        switch self.family {
            case .primary:
                break
            case .secondary:
                self.system_appearanceMode = .color
                self.system_fontSize = 30
                self.system_fontWeight = .bold
                self.system_textColor = .white
                self.system_backgroundColor = .teal
                self.accessory_fontWeight = .black
                self.empty_type = .pencil
            case .tertiary:
                self.system_appearanceMode = .color
                self.system_fontSize = 34
                self.system_fontWeight = .bold
                self.system_fontDesign = .serif
                self.system_textColor = .init(white: 0.3)
                self.system_backgroundColor = .init(white: 0.89)
                self.system_backgroundGradient = true
                self.accessory_fontWeight = .bold
                self.accessory_fontDesign = .serif
                self.empty_type = .userText
        }
    }
}
