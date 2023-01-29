import SwiftUI
import WidgetKit

class 📱AppModel: ObservableObject {
    @Published var 🎛rectangularData = 🎛RectangularDataModel()
    @Published var 🎛circularData = 🎛CircularDataModel()
    @Published var 🎛inlineData = 🎛InlineDataModel()
    
    func 💾saveDataAndReloadWidget() {
        do {
            let ⓤd = UserDefaults(suiteName: 🆔AppGroupID)
            var ⓓata = try JSONEncoder().encode(🎛rectangularData)
            ⓤd?.set(ⓓata, forKey: "Rectangular")
            ⓓata = try JSONEncoder().encode(🎛circularData)
            ⓤd?.set(ⓓata, forKey: "Circular")
            ⓓata = try JSONEncoder().encode(🎛inlineData)
            ⓤd?.set(ⓓata, forKey: "Inline")
        } catch {
            print("🚨Encode error: ", error)
        }
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func 💾loadDatas() {
        let ⓤd = UserDefaults(suiteName: 🆔AppGroupID)
        do {
            if let ⓓata = ⓤd?.data(forKey: "Rectangular") {
                🎛rectangularData = try JSONDecoder().decode(🎛RectangularDataModel.self, from: ⓓata)
            } else { print(#"UserDefaults(suiteName: 🆔AppGroupID).data(forKey: "Rectangular")"#, "is nil.") }
            if let ⓓata = ⓤd?.data(forKey: "Circular") {
                🎛circularData = try JSONDecoder().decode(🎛CircularDataModel.self, from: ⓓata)
            } else { print(#"UserDefaults(suiteName: 🆔AppGroupID).data(forKey: "Circular")"#, "is nil.") }
            if let ⓓata = ⓤd?.data(forKey: "Inline") {
                🎛inlineData = try JSONDecoder().decode(🎛InlineDataModel.self, from: ⓓata)
            } else { print(#"UserDefaults(suiteName: 🆔AppGroupID).data(forKey: "Inline")"#, "is nil.") }
        } catch {
            print("🚨Decode error: ", error)
        }
    }
    
    init() {
        💾loadDatas()
    }
}

let 🆔AppGroupID = "group.net.aaaakkkkssssttttnnnn.LockInNote"

protocol 🄵ontOptions {
    var placeholder: 🄿laceholder { get set }
    var fontSize: Int { get set }
    var fontWeight: 🅆eight { get set }
    var fontDesign: 🄳esign { get set }
    var italic: Bool { get set }
    var level: 🄻evel { get set }
    var multilineTextAlignment: 🄼ultilineTextAlignment { get set }
}

struct 🎛RectangularDataModel: Codable, Equatable, 🄵ontOptions {
    var text: String = ""
    
    var placeholder: 🄿laceholder = .squareAndPencil
    var fontSize: Int = 17
    var fontWeight: 🅆eight = .regular
    var fontDesign: 🄳esign = .default
    var italic: Bool = false
    var level: 🄻evel = .primary
    var multilineTextAlignment: 🄼ultilineTextAlignment = .center
}

struct 🎛CircularDataModel: Codable, Equatable, 🄵ontOptions {
    var text: String = ""
    var background: Bool = true
    
    var placeholder: 🄿laceholder = .squareAndPencil
    var fontSize: Int = 13
    var fontWeight: 🅆eight = .regular
    var fontDesign: 🄳esign = .default
    var italic: Bool = false
    var level: 🄻evel = .primary
    var multilineTextAlignment: 🄼ultilineTextAlignment = .center
}

struct 🎛InlineDataModel: Codable, Equatable {
    var text: String = ""
    var placeholder: 🄿laceholder = .squareAndPencil
}

enum 🄿laceholder: String, Codable, CaseIterable, Identifiable {
    case squareAndPencil = "square and pencil"
    case ellipsis, pencil
    case nothing = "(nothing)"
    var id: Self { self }
    var icon: String {
        switch self {
            case .squareAndPencil: return "square.and.pencil"
            case .ellipsis: return "ellipsis"
            case .pencil: return "pencil"
            case .nothing: return "questionmark.square.dashed"
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
