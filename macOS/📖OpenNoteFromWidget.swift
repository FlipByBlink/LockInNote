import SwiftUI

struct 📖OpenNoteFromWidget: ViewModifier {
    @EnvironmentObject var app: 📱AppModel
    @EnvironmentObject var iap: 🛒InAppPurchaseModel
    @Environment(\.openWindow) var openWindow
    func body(content: Content) -> some View {
        content
            .onChange(of: self.app.requestToOpenNote) {
                if $0 {
                    self.openWindow(id: "note")
                    self.app.requestToOpenNote = false
                    if self.iap.checkToShowADSheet() { self.app.sheet = .ad }
                }
            }
    }
}
