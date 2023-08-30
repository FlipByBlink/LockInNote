import SwiftUI
import WidgetKit

class 📝NoteModel: ObservableObject {
    var family: 📝NoteFamily
    @Published var title: String
    @Published var text: String = ""
    
    @Published var fontWeight: 🎚️FontWeight = .regular
    @Published var fontDesign: 🎚️FontDesign = .default
    @Published var italic: Bool = false
    @Published var multilineTextAlignment: 🎚️MultilineTextAlignment = .center
    
    //==== Empty icon ====
    @Published var empty_type: 🎚️EmptyType = .squareAndPencil
    @Published var empty_iconSize: 🎚️EmptyIconSize = .medium
    @Published var empty_userText: String = ""
    
    //==== WidgetFamily.systemSmall, .systemMedium, .systemLarge, .systemExtraLarge ====
    @Published var system_appearanceMode: 🎚️AppearanceMode = .standard
    @Published var system_fontSize: Int = 20
    @Published var system_hierarchical: 🎚️Hierarchical = .primary
    @Published var system_padding: Int = 12
    @Published var system_contentAlignment: 🎚️ContentAlignment = .center
    @Published var system_textColor: Color = .black
    @Published var system_backgroundColor: Color = .white
    @Published var system_backgroundGradient: Bool = false
    @Published var system_doubleSizeOnLargeWidget: Bool = false
    
    //==== WidgetFamily.accessoryRectangular, .accessoryCircular ====
    @Published var accessory_fontSize: Int = 14
    @Published var accessory_hierarchical: 🎚️Hierarchical = .primary
    @Published var accessoryCircular_backgroundForIOS16AndWatchOS: Bool = false
    
    init(_ ⓝoteFamily: 📝NoteFamily, observeChange ⓞbserveChange: Bool = true) {
        self.family = ⓝoteFamily
        self.title = self.family.loadTitle()
        self.presetValues()
        self.migrateFromVer_1_1()
        📝NoteProperty.allCases.forEach { self.loadICloud($0) }
        if ⓞbserveChange {
            💾ICloud.addObserver(self, #selector(self.iCloudDidChangeExternally(_:)))
        }
    }
}

extension 📝NoteModel {
    func save(_ ⓟroperty: 📝NoteProperty, _ ⓥalue: some Codable) {
        💾ICloud.save(ⓟroperty, self.family, ⓥalue)
        self.reloadWidgetOnMac()
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
            self.reloadWidgetOnMac()
        }
    }
    func loadICloud(_ ⓟroperty: 📝NoteProperty) {
        do {
            switch ⓟroperty {
                case .text: self.text = try 💾ICloud.load(ⓟroperty, self.family)
                case .title: self.title = try 💾ICloud.load(ⓟroperty, self.family)
                case .fontWeight: self.fontWeight = try 💾ICloud.load(ⓟroperty, self.family)
                case .fontDesign: self.fontDesign = try 💾ICloud.load(ⓟroperty, self.family)
                case .italic: self.italic = try 💾ICloud.load(ⓟroperty, self.family)
                case .multilineTextAlignment: self.multilineTextAlignment = try 💾ICloud.load(ⓟroperty, self.family)
                case .empty_type: self.empty_type = try 💾ICloud.load(ⓟroperty, self.family)
                case .empty_userText: self.empty_userText = try 💾ICloud.load(ⓟroperty, self.family)
                case .empty_iconSize: self.empty_iconSize = try 💾ICloud.load(ⓟroperty, self.family)
                case .system_appearanceMode: self.system_appearanceMode = try 💾ICloud.load(ⓟroperty, self.family)
                case .system_fontSize: self.system_fontSize = try 💾ICloud.load(ⓟroperty, self.family)
                case .system_hierarchical: self.system_hierarchical = try 💾ICloud.load(ⓟroperty, self.family)
                case .system_padding: self.system_padding = try 💾ICloud.load(ⓟroperty, self.family)
                case .system_contentAlignment: self.system_contentAlignment = try 💾ICloud.load(ⓟroperty, self.family)
                case .system_textColor: self.system_textColor = (try 💾ICloud.load(ⓟroperty, self.family) as 🎚️Color).swiftUIColor
                case .system_backgroundColor: self.system_backgroundColor = (try 💾ICloud.load(ⓟroperty, self.family) as 🎚️Color).swiftUIColor
                case .system_backgroundGradient: self.system_backgroundGradient = try 💾ICloud.load(ⓟroperty, self.family)
                case .system_doubleSizeOnLargeWidget: self.system_doubleSizeOnLargeWidget = try 💾ICloud.load(ⓟroperty, self.family)
                case .accessory_fontSize: self.accessory_fontSize = try 💾ICloud.load(ⓟroperty, self.family)
                case .accessory_hierarchical: self.accessory_hierarchical = try 💾ICloud.load(ⓟroperty, self.family)
                case .accessoryCircular_backgroundForIOS16AndWatchOS: self.accessoryCircular_backgroundForIOS16AndWatchOS = try 💾ICloud.load(ⓟroperty, self.family)
            }
        } catch 💾ICloud.LoadError.noData {
            return
        } catch {
            print(error, error.localizedDescription); assertionFailure()
        }
    }
}

private extension 📝NoteModel {
    private func presetValues() {
        switch self.family {
            case .primary:
                break
            case .secondary:
                self.fontWeight = .bold
                self.empty_type = .pencil
                self.system_appearanceMode = .color
                self.system_textColor = .white
                self.system_backgroundColor = .teal
            case .tertiary:
                self.fontWeight = .bold
                self.fontDesign = .serif
                self.empty_type = .userText
                self.empty_iconSize = .small
                self.system_appearanceMode = .color
                self.system_textColor = .init(white: 0.3)
                self.system_backgroundColor = .init(white: 0.89)
                self.system_backgroundGradient = true
        }
    }
    private func migrateFromVer_1_1() {
        #if os(iOS) || (watchOS)
        🗄️MigrationFromVer_1_1.execute()
        #endif
    }
    private func reloadWidgetOnMac() {
        #if os(macOS)
        WidgetCenter.shared.reloadAllTimelines()
        #endif
    }
}
