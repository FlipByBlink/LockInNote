//import Foundation
//
//enum 💾UserDefaultsVer_1_1 {
//    private static let api = UserDefaults(suiteName: "group.net.aaaakkkkssssttttnnnn.LockInNote")
//    enum 🄺ey: String {
//        case Rectangular, Circular, Inline
//    }
//    static func load<T: Codable>(_ ⓚey: Self.🄺ey) -> T? {
//        guard let ⓓata = Self.api?.data(forKey: ⓚey.rawValue) else { return nil }
//        do {
//            return try JSONDecoder().decode(T.self, from: ⓓata)
//        } catch {
//            assertionFailure(); return nil
//        }
//    }
//    static func save(_ ⓚey: Self.🄺ey, _ ⓜodel: some Codable) {
//        do {
//            let ⓓata = try JSONEncoder().encode(ⓜodel.self)
//            Self.api?.set(ⓓata, forKey: ⓚey.rawValue)
//        } catch {
//            assertionFailure()
//        }
//    }
//    static var notExists: Bool {
//        Self.api?.data(forKey: Self.🄺ey.Rectangular.rawValue) == nil
//    }
//}
