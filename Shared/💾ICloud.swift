import Foundation

enum 💾ICloud {
    private static let api = NSUbiquitousKeyValueStore.default
}

extension 💾ICloud {
    static func addObserver(_ ⓞbserver: Any, _ ⓢelector: Selector) {
        NotificationCenter.default.addObserver(ⓞbserver,
                                               selector: ⓢelector,
                                               name: NSUbiquitousKeyValueStore.didChangeExternallyNotification,
                                               object: Self.api)
    }
    static func synchronize() {
        Self.api.synchronize()
    }
    static func load<T: Codable>(_ ⓟroperty: 📝NoteProperty, _ ⓝoteFamily: 📝NoteFamily) throws -> T {
        guard let ⓓata = Self.api.data(forKey: Self.encodeKey(ⓟroperty, ⓝoteFamily)) else {
            throw Self.LoadError.noData
        }
        return try JSONDecoder().decode(T.self, from: ⓓata)
    }
    enum LoadError: Error {
        case noData
    }
    static func save(_ ⓟroperty: 📝NoteProperty, _ ⓝoteFamily: 📝NoteFamily, _ ⓥalue: some Codable) {
        do {
            let ⓓata = try JSONEncoder().encode(ⓥalue.self)
            Self.api.set(ⓓata, forKey: Self.encodeKey(ⓟroperty, ⓝoteFamily))
        } catch {
            assertionFailure()
        }
    }
    static func encodeKey(_ ⓟroperty: 📝NoteProperty, _ ⓝoteFamily: 📝NoteFamily) -> String {
        "\(ⓝoteFamily)/\(ⓟroperty)"
    }
    static func decodeKey(_ ⓚey: String, _ ⓝoteFamily: 📝NoteFamily) -> 📝NoteProperty? {
        .allCases.first {
            ⓚey == Self.encodeKey($0, ⓝoteFamily)
        }
    }
}
