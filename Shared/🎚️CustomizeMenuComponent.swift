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
            Label("Level", systemImage: "camera.filters")
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
            Label("ContentAlignment", systemImage: "squareshape.split.3x3")
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

struct 🎚️DoubleSizeOnLargeWidgetToggle: View {
    @EnvironmentObject var note: 📝NoteModel
    var body: some View {
        Toggle(isOn: self.$note.system_doubleSizeOnLargeWidget) {
            Label {
                Text("Double in font-size/padding-size on large widget")
            } icon: {
                Text("×2")
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

struct 🎚️EmptyTextField: View {
    @EnvironmentObject var note: 📝NoteModel
    var body: some View {
        TextField("Input text", text: self.$note.empty_userText)
    }
}

struct 🎚️SystemWidgetPreview: View {
    @EnvironmentObject var note: 📝NoteModel
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 8) {
                Group {
                    switch self.note.system_appearanceMode {
                        case .standard:
                            HStack(spacing: 12) {
                                Group {
                                    🪧SystemFamilyView(isPreview: true)
                                        .environment(\.colorScheme, .light)
                                    🪧SystemFamilyView(isPreview: true)
                                        .environment(\.colorScheme, .dark)
                                }
                                .frame(width: 160, height: 160)
                                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                            }
                            .padding(.horizontal, 8)
                        case .color:
                            🪧SystemFamilyView(isPreview: true)
                                .frame(width: 160, height: 160)
                                .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                    }
                }
                .shadow(color: .gray, radius: 4)
                Text("Preview")
                    .foregroundStyle(.secondary)
                    .tracking(0.5)
                    .font(.subheadline.italic().weight(.light))
            }
            .frame(height: 180)
            .padding(8)
            Spacer()
        }
        .listRowBackground(Color.clear)
    }
}

struct 🎚️AccessoryWidgetPreview: View {
    var body: some View {
        HStack {
            Spacer()
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(.gray.opacity(0.5).gradient)
                    🪧AccessoryFamilyView(isPreview: true)
                }
                #if os(iOS) || os(macOS)
                .frame(width: 210, height: 80)
                #elseif os(watchOS)
                .frame(width: 130, height: 70)
                #endif
                Text("Preview")
                    .foregroundStyle(.secondary)
                    .tracking(0.5)
                    .font(.subheadline.italic().weight(.light))
            }
            Spacer()
        }
        #if os(iOS) || os(macOS)
        .padding(.vertical, 32)
        #elseif os(watchOS)
        .padding(.vertical, 8)
        #endif
        .listRowBackground(Color.clear)
    }
}

struct 🎚️EmptyContentPreview: View {
    var body: some View {
        Section {
            HStack {
                Spacer()
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(.gray.opacity(0.5).gradient)
                        🪧EmptyIconView()
                            #if os(iOS) || os(macOS)
                            .font(.title)
                            #elseif os(watchOS)
                            .font(.title3)
                            #endif
                    }
                    #if os(iOS) || os(macOS)
                    .frame(width: 120, height: 120)
                    #elseif os(watchOS)
                    .frame(width: 60, height: 60)
                    #endif
                    Text("Preview")
                        .foregroundStyle(.secondary)
                        .tracking(0.5)
                        .font(.subheadline.italic().weight(.light))
                }
                Spacer()
            }
            #if os(iOS) || os(macOS)
            .padding(.vertical, 32)
            #elseif os(watchOS)
            .padding(.vertical, 4)
            #endif
            .listRowBackground(Color.clear)
        }
    }
}

struct 🎚️SaveValues: ViewModifier {
    @EnvironmentObject var note: 📝NoteModel
    func body(content: Content) -> some View {
        content
        //MARK: WidgetFamily.systemSmall, .systemMedium, .systemLarge
            .onChange(of: self.note.system_appearanceMode) { self.note.save(.system_appearanceMode, $0) }
            .onChange(of: self.note.system_fontSize) { self.note.save(.system_fontSize, $0) }
            .onChange(of: self.note.system_fontWeight) { self.note.save(.system_fontWeight, $0) }
            .onChange(of: self.note.system_fontDesign) { self.note.save(.system_fontDesign, $0) }
            .onChange(of: self.note.system_hierarchical) { self.note.save(.system_hierarchical, $0) }
            .onChange(of: self.note.system_multilineTextAlignment) { self.note.save(.system_multilineTextAlignment, $0) }
            .onChange(of: self.note.system_italic) { self.note.save(.system_italic, $0) }
            .onChange(of: self.note.system_padding) { self.note.save(.system_padding, $0) }
            .onChange(of: self.note.system_contentAlignment) { self.note.save(.system_contentAlignment, $0) }
            .onChange(of: self.note.system_textColor) { self.note.save(.system_textColor, 🎚️Color($0)) }
            .onChange(of: self.note.system_backgroundColor) { self.note.save(.system_backgroundColor, 🎚️Color($0)) }
            .onChange(of: self.note.system_backgroundGradient) { self.note.save(.system_backgroundGradient, $0) }
            .onChange(of: self.note.system_doubleSizeOnLargeWidget) { self.note.save(.system_doubleSizeOnLargeWidget, $0) }
        
        //MARK: WidgetFamily.accessoryInline, .accessoryCircular, .accessoryRectangular
            .onChange(of: self.note.accessory_fontSize) { self.note.save(.accessory_fontSize, $0) }
            .onChange(of: self.note.accessory_fontWeight) { self.note.save(.accessory_fontWeight, $0) }
            .onChange(of: self.note.accessory_fontDesign) { self.note.save(.accessory_fontDesign, $0) }
            .onChange(of: self.note.accessory_hierarchical) { self.note.save(.accessory_hierarchical, $0) }
            .onChange(of: self.note.accessory_multilineTextAlignment) { self.note.save(.accessory_multilineTextAlignment, $0) }
            .onChange(of: self.note.accessory_italic) { self.note.save(.accessory_italic, $0) }
        
        //MARK: Empty content
            .onChange(of: self.note.empty_type) { self.note.save(.empty_type, $0) }
            .onChange(of: self.note.empty_userText) { self.note.save(.empty_userText, $0) }
    }
}
