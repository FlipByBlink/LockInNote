import SwiftUI

#if os(iOS) || os(macOS)
struct 🎚AppearanceModePicker: View {
    @EnvironmentObject var note: 📝NoteModel
    var body: some View {
        Picker("Mode", selection: self.$note.system_appearanceMode) {
            ForEach(🎚️AppearanceMode.allCases) { Text($0.label) }
        }
        .pickerStyle(.segmented)
        .listRowBackground(Color.clear)
    }
}
#endif

struct 🎚️FontSizeStepper: View {
    @Binding var value: Int
    var body: some View {
        Stepper(value: self.$value, in: 8 ... 100, step: 1) {
            LabeledContent {
                Text(self.value.formatted())
                    .monospacedDigit()
            } label: {
                Label("Size", systemImage: "textformat.size")
            }
        }
    }
}

struct 🎚FontWeightPicker: View {
    @Binding var value: 🎚️FontWeight
    var body: some View {
        Picker(selection: self.$value) {
            ForEach(🎚️FontWeight.allCases) {
                Text($0.label)
                    .font(.system(.body, weight: $0.value))
            }
        } label: {
            Label("Weight", systemImage: "bold")
        }
        //.pickerStyle(.navigationLink) MARK: iOS16 Crash
    }
}

struct 🎚FontDesignPicker: View {
    @Binding var value: 🎚️FontDesign
    var body: some View {
        Picker(selection: self.$value) {
            ForEach(🎚️FontDesign.allCases) {
                Text($0.label)
                    .font(.system(.body, design: $0.value))
            }
        } label: {
            Label("Design", systemImage: "paintbrush.pointed")
        }
        //.pickerStyle(.navigationLink) MARK: iOS16 Crash
    }
}

struct 🎚HierarchicalPicker: View {
    @Binding var value: 🎚️Hierarchical
    var body: some View {
        Picker(selection: self.$value) {
            ForEach(🎚️Hierarchical.allCases) {
                Text($0.label)
                    .foregroundStyle($0.value)
            }
        } label: {
            Label("Hierarchical level", systemImage: "camera.filters")
        }
        //.pickerStyle(.navigationLink) MARK: iOS16 Crash
    }
}

struct 🎚MultilineTextAlignmentPicker: View {
    @Binding var value: 🎚️MultilineTextAlignment
    var body: some View {
        Picker(selection: self.$value) {
            ForEach(🎚️MultilineTextAlignment.allCases) {
                Label($0.label, systemImage: $0.icon)
            }
        } label: {
            Label("Multi line text alignment", systemImage: "align.horizontal.left.fill")
        }
    }
}

struct 🎚ItalicToggle: View {
    @Binding var value: Bool
    var body: some View {
        Toggle(isOn: self.$value) {
            Label("Italic", systemImage: "italic")
        }
    }
}

struct 🎚️PaddingStepper: View {
    @EnvironmentObject var note: 📝NoteModel
    var body: some View {
        Stepper(value: self.$note.system_padding, in: 0 ... 16, step: 1) {
            LabeledContent {
                Text(self.note.system_padding.formatted())
                    .monospacedDigit()
            } label: {
                Label("Padding", systemImage: "squareshape.squareshape.dashed")
            }
        }
    }
}

struct 🎚️ContentAlignmentPicker: View {
    @EnvironmentObject var note: 📝NoteModel
    var body: some View {
        Picker(selection: self.$note.system_contentAlignment) {
            ForEach(🎚️ContentAlignment.allCases) { Text($0.label) }
        } label: {
            Label("Content alignment", systemImage: "squareshape.split.3x3")
        }
    }
}

#if os(iOS) || os(macOS)
struct 🎚️TextColorPicker: View {
    @EnvironmentObject var note: 📝NoteModel
    var body: some View {
        ColorPicker(selection: self.$note.system_textColor, supportsOpacity: false) {
            Label("Text color", systemImage: "paintpalette")
        }
    }
}

struct 🎚️BackgroundColorPicker: View {
    @EnvironmentObject var note: 📝NoteModel
    var body: some View {
        ColorPicker(selection: self.$note.system_backgroundColor, supportsOpacity: false) {
            Label("Background color", systemImage: "paintpalette.fill")
        }
    }
}
#endif

struct 🎚️BackgroundGradientToggle: View {
    @EnvironmentObject var note: 📝NoteModel
    var body: some View {
        Toggle(isOn: self.$note.system_backgroundGradient) {
            Label("Background gradient", systemImage: "sun.dust")
        }
    }
}

#if os(iOS) || os(watchOS)
struct 🎚️AccessaryCircularBackgroundToggleForIOS16AndWatchOS: View {
    @EnvironmentObject var note: 📝NoteModel
    var body: some View {
        Toggle(isOn: self.$note.accessoryCircular_backgroundForIOS16AndWatchOS) {
            Label("Background on circular widget for iOS 16 / watchOS", systemImage: "largecircle.fill.circle")
        }
    }
}
#endif

struct 🎚️DoubleSizeOnLargeWidgetToggle: View {
    @EnvironmentObject var note: 📝NoteModel
    var body: some View {
        Toggle(isOn: self.$note.system_doubleSizeOnLargeWidget) {
            Label {
                Text("Double in font-size/padding-size on large widget")
            } icon: {
                Text(verbatim: "×2")
            }
        }
    }
}

struct 🎚️EmptyTypePicker: View {
    @EnvironmentObject var note: 📝NoteModel
    var body: some View {
        Picker(selection: self.$note.empty_type) {
            ForEach(🎚️EmptyType.allCases) {
                switch $0 {
                    case .squareAndPencil, .ellipsis, .pencil:
                        Label($0.label, systemImage: $0.icon)
                    case .userText, .nothing:
                        Text($0.label)
                }
            }
        } label: {
            Label("Placeholder", systemImage: "questionmark")
        }
    }
}

struct 🎚️EmptyIconSizePicker: View {
    @EnvironmentObject var note: 📝NoteModel
    var body: some View {
        Picker(selection: self.$note.empty_iconSize) {
            ForEach(🎚️EmptyIconSize.allCases) {
                Text($0.label)
            }
        } label: {
            Label("Icon size", systemImage: "textformat.size")
        }
    }
}

struct 🎚️EmptyTextField: View {
    @EnvironmentObject var note: 📝NoteModel
    var body: some View {
        TextField("Input text", text: self.$note.empty_userText)
    }
}
