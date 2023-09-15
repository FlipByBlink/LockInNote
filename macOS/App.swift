import SwiftUI

@main
struct macOSApp: App {
    @NSApplicationDelegateAdaptor var model: 📱AppModel
    var body: some Scene {
        📝NoteWindow(self.model)
        🎚️CustomizeWindow()
        🔗URLSchemeActionMenuWindow()
        🛒InAppPurchaseWindow(self.model)
        ℹ️HelpWindows()
    }
}
