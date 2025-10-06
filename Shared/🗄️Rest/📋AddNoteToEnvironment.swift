import SwiftUI

struct 📋AddNoteToEnvironment: ViewModifier {
    @EnvironmentObject var app: 📱AppModel
    
#if os(iOS) || os(visionOS) || os(watchOS)
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
    
#elseif os(macOS)
    func body(content: Content) -> some View {
        content.environmentObject(self.app.note(self.app.target))
        //TODO: ↓を再検討。↑だとTextEditorが壊れそう。
        //switch self.app.target {
        //    case .primary: content.environmentObject(self.app.primaryNote)
        //    case .secondary: content.environmentObject(self.app.secondaryNote)
        //    case .tertiary: content.environmentObject(self.app.tertiaryNote)
        //}
    }
#endif
}
