import SwiftUI

struct 🔲WindowEdgeFeedback: ViewModifier {
    @EnvironmentObject var app: 📱AppModel
    func body(content: Content) -> some View {
        content
            .overlay {
                if self.app.playingFeedback {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.tint, lineWidth: 5)
                        .ignoresSafeArea()
                }
            }
            .animation(.default.speed(2), value: self.app.playingFeedback)
    }
}
