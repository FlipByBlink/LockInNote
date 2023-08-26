import SwiftUI

struct 📋AddNoteModelToEnvironment: ViewModifier {
    @EnvironmentObject var app: 📱AppModel
    func body(content: Content) -> some View {
        switch self.app.target {
            case .primary: content.environmentObject(self.app.primaryNote)
            case .secondary: content.environmentObject(self.app.secondaryNote)
            case .tertiary: content.environmentObject(self.app.tertiaryNote)
        }
    }
}
