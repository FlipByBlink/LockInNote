
import SwiftUI
import WidgetKit

class 📱AppModel: ObservableObject {
    private static let ⓤd = UserDefaults(suiteName: 🆔AppGroupID)
    @AppStorage("AutoLaunchKeyboard") var 🚩AutoLaunchKeyboard: Bool = false
    
    @Published var 🎛RectangularData = 🎛RectangularDataModel()
    @Published var 🎛InlineData = 🎛InlineDataModel()
    @Published var 🎛CircularData = 🎛CircularDataModel()
    
    func 💾SaveDataAndReloadWidget() {
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
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func 💾LoadDatas() {
        enum 🚨LoadError: Error { case Rectangular, Inline, Circular }
        let ⓤd = UserDefaults(suiteName: 🆔AppGroupID)
        do {
            if let ⓓata = ⓤd?.data(forKey: "Rectangular") {
                🎛RectangularData = try JSONDecoder().decode(🎛RectangularDataModel.self, from: ⓓata)
            } else { throw 🚨LoadError.Rectangular }
            if let ⓓata = ⓤd?.data(forKey: "Inline") {
                🎛InlineData = try JSONDecoder().decode(🎛InlineDataModel.self, from: ⓓata)
            } else { throw 🚨LoadError.Inline }
            if let ⓓata = ⓤd?.data(forKey: "Circular") {
                🎛CircularData = try JSONDecoder().decode(🎛CircularDataModel.self, from: ⓓata)
            } else { throw 🚨LoadError.Circular }
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
    
    var placeholder: 🄿laceholder = .squareAndPencil
    var fontSize: Int = 17
    var fontWeight: 🅆eight = .regular
    var fontDesign: 🄳esign = .default
    var italic: Bool = false
    var level: 🄻evel = .primary
    var multilineTextAlignment: 🄼ultilineTextAlignment = .center
}

struct 🎛InlineDataModel: Codable {
    var text: String = ""
    var placeholder: 🄿laceholder = .squareAndPencil
}

struct 🎛CircularDataModel: Codable {
    var text: String = ""
    var background: Bool = true
    
    var placeholder: 🄿laceholder = .squareAndPencil
    var fontSize: Int = 17
    var fontWeight: 🅆eight = .regular
    var fontDesign: 🄳esign = .default
    var italic: Bool = false
    var level: 🄻evel = .primary
    var multilineTextAlignment: 🄼ultilineTextAlignment = .center
}

enum 🄿laceholder: String, Codable, CaseIterable, Identifiable { //TODO: 実装
    case squareAndPencil = "square and pencil"//, useredit
    case threedot, pencil
    case nothing = "(nothing)"
    var id: Self { self }
    var icon: String? {
        switch self {
            case .squareAndPencil: return "square.and.pencil"
            case .threedot: return "ellipsis"
            case .pencil: return "pencil"
            case .nothing: return nil
        }
    }
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
