import SwiftUI
import WidgetKit

struct 🪧ReloadWidgetsOnActive: ViewModifier {
    @Environment(\.scenePhase) var scenePhase
    func body(content: Content) -> some View {
        content
            .onChange(of: self.scenePhase) {
                if $1 == .active {
                    WidgetCenter.shared.reloadAllTimelines()
                }
            }
    }
}
