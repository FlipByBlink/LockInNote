import SwiftUI
import WatchConnectivity

struct 🎛WidgetsModel: Codable, Equatable {
    var rectangular: 🎛RectangularWidgetModel = .load() ?? .default
    var circular: 🎛CircularWidgetModel = .load() ?? .default
    var inline: 🎛InlineWidgetModel = .load() ?? .default
    func save() {
        self.rectangular.save()
        self.circular.save()
        self.inline.save()
    }
    var asData: Data? { try? JSONEncoder().encode(self) }
    mutating func receiveWCContext(_ ⓒontext: [String: Any]) {
        if let ⓓata = ⓒontext["ⓒontext"] as? Data {
            do {
                self = try JSONDecoder().decode(Self.self, from: ⓓata)
                self.save()
            } catch {
                print("🚨", error); assertionFailure()
            }
        } else {
            //assertionFailure() シミュレーターだとダメ
        }
    }
    func updateWCContext() {
        do {
            let ⓓata = try JSONEncoder().encode(self)
            try? WCSession.default.updateApplicationContext(["ⓒontext": ⓓata])
        } catch {
            assertionFailure()
        }
    }
}

struct 🎛RectangularWidgetModel: Codable, Equatable, 🄵ontOptions {
    var text: String = ""
    
    var placeholder: 🄿laceholder = .squareAndPencil
    var fontSize: Int = 17
    var fontWeight: 🅆eight = .regular
    var fontDesign: 🄳esign = .default
    var italic: Bool = false
    var level: 🄻evel = .primary
    var multilineTextAlignment: 🄼ultilineTextAlignment = .center
    
    static var `default`: Self { Self() }
    static func load() -> Self? { 💾UserDefaults.load(.Rectangular) }
    func save() { 💾UserDefaults.save(.Rectangular, self) }
}

struct 🎛CircularWidgetModel: Codable, Equatable, 🄵ontOptions {
    var text: String = ""
    var background: Bool = true
    
    var placeholder: 🄿laceholder = .squareAndPencil
    var fontSize: Int = 13
    var fontWeight: 🅆eight = .regular
    var fontDesign: 🄳esign = .default
    var italic: Bool = false
    var level: 🄻evel = .primary
    var multilineTextAlignment: 🄼ultilineTextAlignment = .center
    
    static var `default`: Self { Self() }
    static func load() -> Self? { 💾UserDefaults.load(.Circular) }
    func save() { 💾UserDefaults.save(.Circular, self) }
}

struct 🎛InlineWidgetModel: Codable, Equatable {
    var text: String = ""
    var placeholder: 🄿laceholder = .squareAndPencil
    
    static var `default`: Self { Self() }
    static func load() -> Self? { 💾UserDefaults.load(.Inline) }
    func save() { 💾UserDefaults.save(.Inline, self) }
}

enum 💾UserDefaults {
    private static let ⓐpi = UserDefaults(suiteName: "group.net.aaaakkkkssssttttnnnn.LockInNote")
    enum 🄺ey: String {
        case Rectangular, Circular, Inline
    }
    static func load<T: Codable>(_ ⓚey: Self.🄺ey) -> T? {
        guard let ⓓata = Self.ⓐpi?.data(forKey: ⓚey.rawValue) else { return nil }
        do {
            return try JSONDecoder().decode(T.self, from: ⓓata)
        } catch {
            assertionFailure(); return nil
        }
    }
    static func save(_ ⓚey: Self.🄺ey, _ ⓜodel: some Codable) {
        do {
            let ⓓata = try JSONEncoder().encode(ⓜodel.self)
            Self.ⓐpi?.set(ⓓata, forKey: ⓚey.rawValue)
        } catch {
            assertionFailure()
        }
    }
}

protocol 🄵ontOptions {
    var placeholder: 🄿laceholder { get set }
    var fontSize: Int { get set }
    var fontWeight: 🅆eight { get set }
    var fontDesign: 🄳esign { get set }
    var italic: Bool { get set }
    var level: 🄻evel { get set }
    var multilineTextAlignment: 🄼ultilineTextAlignment { get set }
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
