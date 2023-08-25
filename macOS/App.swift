import SwiftUI

@main
struct macOSApp: App {
    @NSApplicationDelegateAdaptor var model: 📱AppModel
    private let iapModel: 🛒InAppPurchaseModel = .init(id: "LockInNote.adfree")
    var body: some Scene {
        📝NoteWindow(self.model)
        🎚️CustomizeWindow(self.model)
        🔗URLSchemeActionMenuWindow()
        ℹ️HelpWindows()
        🛒InAppPurchaseWindow(self.iapModel)
        🔧Settings()
    }
}
