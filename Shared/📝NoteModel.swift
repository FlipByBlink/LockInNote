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
    @Published var accessoryCircular_backgroundForIOS16AndWatchOS: Bool = true
    
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
        self.reloadWidget()
    }
}

private extension 📝NoteModel {
    @objc private func iCloudDidChangeExternally(_ ⓝotification: Notification) {
        guard let ⓒhangedKeys = ⓝotification.userInfo?["NSUbiquitousKeyValueStoreChangedKeysKey"] as? [String] else {
            return
        }
        Task { @MainActor in
            ⓒhangedKeys.forEach {
                if let ⓒhangedProperty = 💾ICloud.decodeKey($0, self.family) {
                    self.loadICloud(ⓒhangedProperty)
                }
            }
            self.reloadWidget()
        }
    }
    private func loadICloud(_ ⓟroperty: 📝NoteProperty) {
        do {
            switch ⓟroperty {
                case .text: self.text = try self.load(ⓟroperty)
                case .title: self.title = try self.load(ⓟroperty)
                case .fontWeight: self.fontWeight = try self.load(ⓟroperty)
                case .fontDesign: self.fontDesign = try self.load(ⓟroperty)
                case .italic: self.italic = try self.load(ⓟroperty)
                case .multilineTextAlignment: self.multilineTextAlignment = try self.load(ⓟroperty)
                case .empty_type: self.empty_type = try self.load(ⓟroperty)
                case .empty_userText: self.empty_userText = try self.load(ⓟroperty)
                case .empty_iconSize: self.empty_iconSize = try self.load(ⓟroperty)
                case .system_appearanceMode: self.system_appearanceMode = try self.load(ⓟroperty)
                case .system_fontSize: self.system_fontSize = try self.load(ⓟroperty)
                case .system_hierarchical: self.system_hierarchical = try self.load(ⓟroperty)
                case .system_padding: self.system_padding = try self.load(ⓟroperty)
                case .system_contentAlignment: self.system_contentAlignment = try self.load(ⓟroperty)
                case .system_textColor: self.system_textColor = (try self.load(ⓟroperty) as 🎚️Color).value
                case .system_backgroundColor: self.system_backgroundColor = (try self.load(ⓟroperty) as 🎚️Color).value
                case .system_backgroundGradient: self.system_backgroundGradient = try self.load(ⓟroperty)
                case .system_doubleSizeOnLargeWidget: self.system_doubleSizeOnLargeWidget = try self.load(ⓟroperty)
                case .accessory_fontSize: self.accessory_fontSize = try self.load(ⓟroperty)
                case .accessory_hierarchical: self.accessory_hierarchical = try self.load(ⓟroperty)
                case .accessoryCircular_backgroundForIOS16AndWatchOS: self.accessoryCircular_backgroundForIOS16AndWatchOS = try self.load(ⓟroperty)
            }
        } catch 💾ICloud.LoadError.noData {
            return
        } catch {
            print(error, error.localizedDescription); assertionFailure()
        }
    }
    private func load<T: Codable>(_ ⓟroperty: 📝NoteProperty) throws -> T {
        try 💾ICloud.load(ⓟroperty, self.family)
    }
    private func reloadWidget() {
        WidgetCenter.shared.reloadTimelines(ofKind: 🗄️MigrationFromVer_1_1.widgetKind(self.family))
    }
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
}
