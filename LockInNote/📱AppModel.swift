
import SwiftUI
import WidgetKit

class 📱AppModel: ObservableObject {
    
    @Published var 🚩ShowWidgetSheet: Bool = false
    @Published var 🆔OpenedWidgetID: String? = nil
    
    private static let ⓤd = UserDefaults(suiteName: 🆔AppGroupID)
    @AppStorage("AutoLaunchKeyboard", store: ⓤd) var 🚩AutoLaunchKeyboard: Bool = false
    
    @Published var ⓦidgetsData: [🎛WidgetData] = [.init(.inline), .init(.rectangular), .init(.circular)]
    @Published var ⓐctiveFamilys: Set<🄵amily> = []
    
    func GetLatestWidgetInfo() {
        WidgetCenter.shared.getCurrentConfigurations { ⓡesult in
            switch ⓡesult {
                case .success(let ⓘnfos):
                    DispatchQueue.main.async {
                        var ⓕamilys: Set<🄵amily> = []
                        for ⓘnfo in ⓘnfos {
                            switch ⓘnfo.family {
                                case .accessoryInline: ⓕamilys.insert(.inline)
                                case .accessoryRectangular: ⓕamilys.insert(.rectangular)
                                case .accessoryCircular: ⓕamilys.insert(.circular)
                                default: continue
                            }
                        }
                        self.ⓐctiveFamilys = ⓕamilys
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


enum 🄵amily: String, Codable, CaseIterable, Identifiable {
    case inline, rectangular, circular
    var id: Self { self }
}

struct 🎛WidgetData: Codable, Identifiable {
    var family: 🄵amily
    var text: String = "Abcd"
    var placeholder: 🄿laceholder = .threedot
    
    var id: 🄵amily { family }
    
    var customization: 🄲ustomization?
    
    struct 🄲ustomization: Codable {
        var fontStyle: 🅂tyle
        var fontWeight: 🅆eight
        var fontDesign: 🄳esign
        var italic: Bool
        var background: Bool
        var level: 🄻evel
        var multilineTextAlignment: 🄼ultilineTextAlignment
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
    
    func 🄴qual(_ ⓕamily: WidgetFamily) -> Bool {
        switch family {
            case .inline:
                if ⓕamily != .accessoryInline { return false }
            case .rectangular:
                if ⓕamily != .accessoryRectangular { return false }
            case .circular:
                if ⓕamily != .accessoryCircular { return false }
        }
        return true
    }
    
    init(_ family: 🄵amily) {
        self.family = family
    }
}
