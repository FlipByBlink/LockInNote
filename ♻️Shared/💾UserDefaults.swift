import Foundation

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
    static var notExists: Bool {
        Self.ⓐpi?.data(forKey: Self.🄺ey.Rectangular.rawValue) == nil
    }
}

enum 💾iCloud {
    private static let ⓐpi = NSUbiquitousKeyValueStore.default
    static func load() -> 🎛WidgetsModel? {
        guard let ⓓata = Self.ⓐpi.data(forKey: "ⓦidgetsModel") else { return nil }
        do {
            return try JSONDecoder().decode(🎛WidgetsModel.self, from: ⓓata)
        } catch {
            assertionFailure(); return nil
        }
    }
    static func save(_ ⓜodel: 🎛WidgetsModel) {
        do {
            let ⓓata = try JSONEncoder().encode(ⓜodel)
            Self.ⓐpi.set(ⓓata, forKey: "ⓦidgetsModel")
        } catch {
            assertionFailure()
        }
    }
}
