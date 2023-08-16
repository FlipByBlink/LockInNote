import Foundation

enum 💾ICloud {
    private static let api = NSUbiquitousKeyValueStore.default
    static func load() -> 🎛WidgetsModel? {
        guard let ⓓata = Self.api.data(forKey: "ⓦidgetsModel") else { return nil }
        do {
            return try JSONDecoder().decode(🎛WidgetsModel.self, from: ⓓata)
        } catch {
            assertionFailure(); return nil
        }
    }
    static func save(_ ⓜodel: 🎛WidgetsModel) {
        do {
            let ⓓata = try JSONEncoder().encode(ⓜodel)
            Self.api.set(ⓓata, forKey: "ⓦidgetsModel")
        } catch {
            assertionFailure()
        }
    }
}
