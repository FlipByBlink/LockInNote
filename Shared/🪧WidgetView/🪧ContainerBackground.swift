import SwiftUI

struct 🪧ContainerBackground: ViewModifier {
    @Environment(\.widgetRenderingMode) var widgetRenderingMode
    func body(content: Content) -> some View {
        if #available(iOS 17.0, watchOS 10.0, macOS 14.0, *) {
#if os(watchOS)
            if self.widgetRenderingMode == .fullColor {
                content.containerBackground(.white, for: .widget)
            } else {
                content.containerBackground(.clear, for: .widget)
            }
#else
            content.containerBackground(.clear, for: .widget)
#endif
        } else {
            content
        }
    }
}
