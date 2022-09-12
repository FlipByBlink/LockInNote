
import SwiftUI
import WidgetKit

class 📱AppModel: ObservableObject {
    
    @Published var 🚩ShowWidgetSheet: Bool = false
    @Published var 🆔OpenedWidgetID: String? = nil
    
    private static let ⓤd = UserDefaults(suiteName: 🆔AppGroupID)
    @AppStorage("AutoLaunchKeyboard", store: ⓤd) var 🚩AutoLaunchKeyboard: Bool = false
    
    @Published var ⓦidgetsData: [🎛WidgetData] = []
    
    func GetLatestWidgetInfo() {
        WidgetCenter.shared.getCurrentConfigurations { ⓡesult in
            switch ⓡesult {
                case .success(let success):
                    DispatchQueue.main.async {
                        var datas: [🎛WidgetData] = []
                        for info in success {
                            datas.append(🎛WidgetData(info.kind, info.family))
                        }
                        self.ⓦidgetsData = datas
                    }
                case .failure(let failure):
                    print(failure)
            }
        }
    }
    
    func 💾SaveDatas() {
        do {
            let ⓓata = try JSONEncoder().encode(ⓦidgetsData)
            let ⓤd = UserDefaults(suiteName: 🆔AppGroupID)
            ⓤd?.set(ⓓata, forKey: "widgetsData")
        } catch {
            print("🚨Error: ", error)
        }
    }
    
    func 💾LoadDatas() {
        let ⓤd = UserDefaults(suiteName: 🆔AppGroupID)
        guard let ⓓata = ⓤd?.data(forKey: "widgetsData") else { return }
        do {
            ⓦidgetsData = try JSONDecoder().decode([🎛WidgetData].self, from: ⓓata)
        } catch {
            print("🚨Error: ", error)
        }
    }
    
    init() {
        💾LoadDatas()
    }
}

let 🆔AppGroupID = "group.net.aaaakkkkssssttttnnnn.LockInNote"


struct 🎛WidgetData: Codable, Identifiable {
    var kind: 🄺ind
    var family: 🄵amily
    var text: String = ""
    var placeholder: 🄿laceholder = .threedot
    
    var id: String { kind.rawValue + family.rawValue }
    
    var fontStyle: 🅂tyle?
    var fontWeight: 🅆eight?
    var fontDesign: 🄳esign?
    var italic: Bool?
    var background: Bool?
    var level: 🄻evel?
    var multilineTextAlignment: 🄼ultilineTextAlignment?
    
    enum 🄺ind: String, Codable, CaseIterable, Identifiable {
        case main, sub
        var id: Self { self }
    }
    
    enum 🄵amily: String, Codable, CaseIterable, Identifiable {
        case inline, rectangular, circular
        var id: Self { self }
    }
    
    enum 🄿laceholder: Codable, CaseIterable, Identifiable {
        case nothing, threedot, pencil, useredit
        var id: Self { self }
    }
    
    enum 🅂tyle: Codable, CaseIterable, Identifiable {
        case body, title3, title2, title, largetitle, subheadline, caption
        var id: Self { self }
    }
    
    enum 🅆eight: Codable, CaseIterable, Identifiable {
        case ultraLight, thin, light, regular, medium, semibold, bold, heavy, black
        var id: Self { self }
    }
    
    enum 🄳esign: Codable, CaseIterable, Identifiable {
        case `default`, serif, rounded, monospaced
        var id: Self { self }
    }
    
    enum 🄻evel: Codable, CaseIterable, Identifiable {
        case primary, secondary, tertiary, quaternary
        var id: Self { self }
    }
    
    enum 🄼ultilineTextAlignment: Codable, CaseIterable, Identifiable {
        case leading, center, trailing
        var id: Self { self }
    }
    
    init(_ kind: String, _ family: WidgetFamily) {
        self.kind = .init(rawValue: kind) ?? .main
        switch family {
            case .accessoryInline: self.family = .inline
            case .accessoryRectangular: self.family = .rectangular
            case .accessoryCircular: self.family = .circular
            default: self.family = .rectangular
        }
    }
}
