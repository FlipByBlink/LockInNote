import SwiftUI

struct 📋AddNoteToEnvironment: ViewModifier {
    @EnvironmentObject var app: 📱AppModel
    var target: 📝NoteFamily
    func body(content: Content) -> some View {
        switch self.target {
            case .primary: content.environmentObject(self.app.primaryNote)
            case .secondary: content.environmentObject(self.app.secondaryNote)
            case .tertiary: content.environmentObject(self.app.tertiaryNote)
        }
    }
    init(_ target: 📝NoteFamily) {
        self.target = target
    }
}
