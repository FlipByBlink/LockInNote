
import SwiftUI
import WidgetKit

class 📱AppModel: ObservableObject {
    
    @Published var 📓Text: String = ""
    @Published var Infos: [WidgetInfo] = []
    
    @Published var 🎚Style: Font.TextStyle = .body
    @Published var 🎚Weight: Font.Weight = .regular
    @Published var 🎚Design: Font.Design = .default
    @Published var 🎚Level: 🄻evelEnum = .primary
    
    private static let ⓤd = UserDefaults(suiteName: 🆔AppGroupID)
}

let 🆔AppGroupID = "group.net.aaaakkkkssssttttnnnn.LockInNote"

enum 🄻evelEnum: CaseIterable, Hashable, Identifiable {
    case primary
    case secondary
    case tertiary
    case quaternary
    var id: 🄻evelEnum { self }
}
