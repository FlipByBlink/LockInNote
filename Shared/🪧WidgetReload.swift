import SwiftUI
import WidgetKit

struct 🪧WidgetReload: ViewModifier {
    @Environment(\.scenePhase) var scenePhase
    func body(content: Content) -> some View {
        content
            .onChange(of: self.scenePhase) { [scenePhase] ⓝewValue in
                if scenePhase == .active, [.inactive, .background].contains(ⓝewValue) {
                    WidgetCenter.shared.reloadAllTimelines()
                }
            }
    }
}
