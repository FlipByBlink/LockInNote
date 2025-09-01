import SwiftUI

struct 🎚️CustomizeMenu: View {
    @EnvironmentObject var note: 📝NoteModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            List {
                🎚️SharedOptionSection()
#if os(iOS)
                🎚️SystemWidgetMenuLink()
                🎚️AccessoryWidgetMenuLink()
#endif
                🎚️TitleTextFieldLink()
            }
            .navigationTitle("Customize \"\(self.note.title)\"")
            .navigationBarTitleDisplayMode(.inline)
            //MARK: ↑ WorkaroundIOS17Bug(navigationTitleMode/navigationLinkPotision)
            .toolbar { self.dismissButton() }
        }
        .modifier(🎚️SaveValues())
    }
}

private extension 🎚️CustomizeMenu {
    private func dismissButton() -> some View {
#if os(visionOS)
        Button(role: .close) { self.dismiss() }
#else
        Button {
            self.dismiss()
        } label: {
            🅧DismissButtonLabel()
        }
#endif
    }
}
