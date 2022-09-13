
import SwiftUI
import WidgetKit

class 📱AppModel: ObservableObject {
    private static let ⓤd = UserDefaults(suiteName: 🆔AppGroupID)
    @AppStorage("AutoLaunchKeyboard") var 🚩AutoLaunchKeyboard: Bool = false
    
    @Published var 🎛RectangularData = 🎛RectangularDataModel() {
        didSet {
            💾SaveDatas()
            WidgetCenter.shared.reloadTimelines(ofKind: "Rectangular")
        }
    }
    
    @Published var 🎛InlineData = 🎛InlineDataModel() {
        didSet {
            💾SaveDatas()
            WidgetCenter.shared.reloadTimelines(ofKind: "Inline")
        }
    }
    
    @Published var 🎛CircularData = 🎛CircularDataModel() {
        didSet {
            💾SaveDatas()
            WidgetCenter.shared.reloadTimelines(ofKind: "Circular")
        }
    }
    
    func 💾SaveDatas() {
        do {
            let ⓤd = UserDefaults(suiteName: 🆔AppGroupID)
            var ⓓata = try JSONEncoder().encode(🎛RectangularData)
            ⓤd?.set(ⓓata, forKey: "Rectangular")
            ⓓata = try JSONEncoder().encode(🎛InlineData)
            ⓤd?.set(ⓓata, forKey: "Inline")
            ⓓata = try JSONEncoder().encode(🎛CircularData)
            ⓤd?.set(ⓓata, forKey: "Circular")
        } catch {
            print("🚨Error: ", error)
        }
    }
    
    func 💾LoadDatas() {
        let ⓤd = UserDefaults(suiteName: 🆔AppGroupID)
        do {
            if let ⓓata = ⓤd?.data(forKey: "Rectangular") {
                🎛RectangularData = try JSONDecoder().decode(🎛RectangularDataModel.self, from: ⓓata)
            }
            if let ⓓata = ⓤd?.data(forKey: "Inline") {
                🎛InlineData = try JSONDecoder().decode(🎛InlineDataModel.self, from: ⓓata)
            }
            if let ⓓata = ⓤd?.data(forKey: "Circular") {
                🎛CircularData = try JSONDecoder().decode(🎛CircularDataModel.self, from: ⓓata)
            }
        } catch {
            print("🚨Error: ", error)
        }
    }
    
    init() {
        💾LoadDatas()
    }
}

let 🆔AppGroupID = "group.net.aaaakkkkssssttttnnnn.LockInNote"

struct 🎛RectangularDataModel: Codable {
    var text: String = ""
    
    var placeholder: 🄿laceholder = .threedot
    var fontSize: Int = 17
    var fontWeight: 🅆eight = .regular
    var fontDesign: 🄳esign = .default
    var italic: Bool = false
    var background: Bool = false
    var level: 🄻evel = .primary
    var multilineTextAlignment: 🄼ultilineTextAlignment = .center
}

struct 🎛InlineDataModel: Codable {
    var text: String = ""
    var placeholder: 🄿laceholder = .threedot
}

struct 🎛CircularDataModel: Codable {
    var text: String = ""
    
    var placeholder: 🄿laceholder = .threedot
    var fontSize: Int = 17
    var fontWeight: 🅆eight = .regular
    var fontDesign: 🄳esign = .default
    var italic: Bool = false
    var background: Bool = true
    var level: 🄻evel = .primary
    var multilineTextAlignment: 🄼ultilineTextAlignment = .center
}

enum 🄿laceholder: String, Codable, CaseIterable, Identifiable { //TODO: 実装
    case nothing, threedot, pencil, useredit
    var id: Self { self }
}

enum 🅆eight: String, Codable, CaseIterable, Identifiable {
    case ultraLight, thin, light, regular, medium, semibold, bold, heavy, black
    var id: Self { self }
    var value: Font.Weight {
        switch self {
            case .ultraLight: return .ultraLight
            case .thin: return .thin
            case .light: return .light
            case .regular: return .regular
            case .medium: return .medium
            case .semibold: return .semibold
            case .bold: return .bold
            case .heavy: return .heavy
            case .black: return .black
        }
    }
}

enum 🄳esign: String, Codable, CaseIterable, Identifiable {
    case `default`, serif, rounded, monospaced
    var id: Self { self }
    var value: Font.Design {
        switch self {
            case .default: return .default
            case .serif: return .serif
            case .rounded: return .rounded
            case .monospaced: return .monospaced
        }
    }
}

enum 🄻evel: String, Codable, CaseIterable, Identifiable {
    case primary, secondary, tertiary, quaternary
    var id: Self { self }
    var value: HierarchicalShapeStyle {
        switch self {
            case .primary: return .primary
            case .secondary: return .secondary
            case .tertiary: return .tertiary
            case .quaternary: return .quaternary
        }
    }
}

enum 🄼ultilineTextAlignment: String, Codable, CaseIterable, Identifiable {
    case leading, center, trailing
    var id: Self { self }
    var value: TextAlignment {
        switch self {
            case .leading: return .leading
            case .center: return .center
            case .trailing: return .trailing
        }
    }
    var icon: String {
        switch self {
            case .leading: return "text.justify.leading"
            case .center: return "text.aligncenter"
            case .trailing: return "text.justify.trailing"
        }
    }
}
