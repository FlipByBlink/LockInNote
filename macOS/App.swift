import SwiftUI

@main
struct macOSApp: App {
    @NSApplicationDelegateAdaptor var model: 📱AppModel
    var body: some Scene {
        📝NoteWindow(self.model)
        🎚️CustomizeWindow(self.model)
        🔗URLSchemeActionMenuWindow()
        Settings { 🔧Settings() }
        //ℹ️HelpWindows()
        //🛒InAppPurchaseWindow(🛒)
    }
}
