
import SwiftUI
import WidgetKit

class 📱AppModel: ObservableObject {
    
    @Published var 🚩ShowWidgetSheet: Bool = false
    @Published var 🆔OpenedWidgetID: String? = nil
    
    private static let ⓤd = UserDefaults(suiteName: 🆔AppGroupID)
    @AppStorage("AutoLaunchKeyboard", store: ⓤd) var 🚩AutoLaunchKeyboard: Bool = false
    
    @Published var ⓦidgetsData: [🎛WidgetData] = []
    @Published var ⓐctiveWidgets: Set<🄵amily> = []
    
    func GetLatestWidgetInfo() {
        WidgetCenter.shared.getCurrentConfigurations { ⓡesult in
            switch ⓡesult {
                case .success(let ⓘnfos):
                    DispatchQueue.main.async {
                        var ⓣypes: Set<🄵amily> = []
                        for ⓘnfo in ⓘnfos {
                            let ⓣype: 🄵amily
                            switch ⓘnfo.family {
                                case .accessoryInline: ⓣype = .inline
                                case .accessoryRectangular: ⓣype = .rectangular
                                case .accessoryCircular: ⓣype = .circular
                                default: continue
                            }
                            if !self.ⓦidgetsData.contains(where: {$0.id==ⓣype}) {
                                self.ⓦidgetsData.append(🎛WidgetData(ⓘnfo.family))
                            }
                            ⓣypes.insert(ⓣype)
                        }
                        self.ⓐctiveWidgets = ⓣypes
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
    var text: String = ""
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
    
    enum 🄺ind: String, Codable, CaseIterable, Identifiable {
        case main, sub
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
    
    init(_ ⓕamily: WidgetFamily) {
        switch ⓕamily {
            case .accessoryInline: family = .inline
            case .accessoryRectangular: family = .rectangular
            case .accessoryCircular: family = .circular
            default: family = .rectangular
        }
    }
}
