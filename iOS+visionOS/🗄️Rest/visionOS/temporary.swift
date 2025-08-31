import SwiftUI

//MARK: temporary definition

class 🛒InAppPurchaseModel: ObservableObject {
    init(id: String) {}
    func checkToShowADSheet() -> Bool { false }
}

struct 📣ADSheet: View {
    var body: some View { EmptyView() }
}
