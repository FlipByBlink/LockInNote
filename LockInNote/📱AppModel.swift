
import SwiftUI
import WidgetKit

class 📱AppModel: ObservableObject {
    
    @AppStorage("AutoLaunchKeyboard", store: ⓤd) var 🚩AutoLaunchKeyboard: Bool = false
    
    @Published var 📓Text: String = ""
    @Published var Infos: [WidgetInfo] = []
    
    @Published var widgets: [🎛WidgetCustomization] = []
    
    @Published var 🎚Style: Font.TextStyle = .body
    @Published var 🎚Weight: Font.Weight = .regular
    @Published var 🎚Design: Font.Design = .default
    @Published var 🎚Level: 🄻evelEnum = .primary
    
    private static let ⓤd = UserDefaults(suiteName: 🆔AppGroupID)
}

let 🆔AppGroupID = "group.net.aaaakkkkssssttttnnnn.LockInNote"


struct 🎛WidgetCustomization: Codable, Identifiable {
    var id: UUID
    var text: String
    var placeholder: 🄿laceholder
    
    var fontStyle: 🅂tyle?
    var fontWeight: 🅆eight?
    var fontDesign: 🄳esign?
    var italic: Bool?
    var background: Bool?
    var level: 🄻evel?
    var multilineTextAlignment: 🄼ultilineTextAlignment?
    
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
}


enum 🄻evelEnum: CaseIterable, Hashable, Identifiable {
    case primary, secondary, tertiary, quaternary
    var id: Self { self }
}
