import SwiftUI

@main
struct macOSApp: App {
    @NSApplicationDelegateAdaptor var appModel: 📱AppModel
    private let iapModel: 🛒InAppPurchaseModel = .init(id: "LockInNote.adfree")
    var body: some Scene {
        📝NoteWindow(self.appModel)
        🎚️CustomizeWindow(self.appModel)
        🔗URLSchemeActionMenuWindow()
        🛒InAppPurchaseWindow(self.iapModel)
        🔧Settings()
        ℹ️HelpWindows()
    }
}
