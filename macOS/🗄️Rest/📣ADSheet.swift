import SwiftUI

struct 📣ADSheet: ViewModifier {
    @EnvironmentObject var app: 📱AppModel
    @State private var targetContent: 📣ADTargetApp = .pickUpAppWithout(.LockInNote)
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: self.$app.showADSheet) {
                📣ADContent(self.targetContent, second: 8)
            }
    }
}
