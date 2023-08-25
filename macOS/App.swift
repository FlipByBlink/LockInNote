import SwiftUI

@main
struct macOSApp: App {
    @NSApplicationDelegateAdaptor var model: 📱AppModel
    var body: some Scene {
        📝NoteWindow(self.model)
        🎚️CustomizeWindow(self.model)
        🔗URLSchemeActionMenuWindow()
        🛒InAppPurchaseWindow(self.model)
        🔧Settings()
        ℹ️HelpWindows()
    }
}
