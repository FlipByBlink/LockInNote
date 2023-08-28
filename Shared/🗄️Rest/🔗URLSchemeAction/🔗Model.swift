import SwiftUI

class 🔗URLSchemeActionModel: ObservableObject {
    @AppStorage("URLSchemeLeading") var leading: String = ""
    @AppStorage("URLSchemeTrailing") var trailing: String = ""
    @AppStorage("URLSchemeButtonTitle") var buttonCustomizeTitle: String = ""
    @AppStorage("EraseTextAfterAction") var eraseTextAfterAction: Bool = false
    func url(_ ⓠuery: String) -> URL? {
        (self.leading + ⓠuery + self.trailing)
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            .flatMap { URL(string: $0) }
    }
    var buttonTitle: LocalizedStringKey {
        .init(self.buttonCustomizeTitle.isEmpty ? "URL Scheme Action" : self.buttonCustomizeTitle)
    }
}
