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
#if os(visionOS)
            🎚️FontSizeStepper(value: self.$note.system_fontSize)
            🎚️PaddingStepper()
            🎚️ContentAlignmentPicker()
            🎚️SystemWidgetMenuLink()
            🎚️DoubleSizeOnLargeWidgetMenuLink()
#endif
            🎚EmptyIconMenuLink()
        }
    }
}
