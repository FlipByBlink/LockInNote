import SwiftUI

struct 🎚️SharedOptionSection: View {
    @EnvironmentObject var note: 📝NoteModel
    var body: some View {
        🎚️SharedOptionPreview()
        Section {
            🎚FontWeightPicker()
            🎚FontDesignPicker()
            🎚ItalicToggle()
            🎚MultilineTextAlignmentPicker()
#if os(iOS)
            🎚EmptyIconMenuLink()
#elseif os(visionOS)
            🎚️FontSizeStepper(value: self.$note.system_fontSize)
            🎚️PaddingStepper()
            🎚️ContentAlignmentPicker()
            🎚️SystemWidgetMenuLink()
            🎚EmptyIconMenuLink()
            🎚️DoubleSizeOnLargeWidgetMenuLink()
#endif
        }
    }
}
