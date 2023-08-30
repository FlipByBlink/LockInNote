import SwiftUI

struct 🎚️CustomizeMenu: View {
    @EnvironmentObject var note: 📝NoteModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            List {
                🎚️SharedOptionSection()
                🎚️SystemWidgetMenuLink()
                🎚️AccessoryWidgetMenuLink()
            }
            .navigationTitle("Customize \"\(self.note.title)\"")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                Button {
                    self.dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .grayscale(1)
                }
            }
        }
        .modifier(🎚️SaveValues())
    }
}

private struct 🎚️SharedOptionSection: View {
    @EnvironmentObject var note: 📝NoteModel
    var body: some View {
        Self.Preview()
        Section {
            🎚FontWeightPicker()
            🎚FontDesignPicker()
            🎚ItalicToggle()
            🎚MultilineTextAlignmentPicker()
            🎚️EmptyIconMenuLink()
        }
    }
    private struct Preview: View {
        @EnvironmentObject var note: 📝NoteModel
        var body: some View {
            HStack {
                Spacer()
                VStack(spacing: 6) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(.gray.opacity(0.5).gradient)
                        Group {
                            if self.note.text.isEmpty {
                                Text(verbatim: "This is a placeholder.\nこれは仮の文章です。\n이것은 플레이스 홀더입니다.")
                            } else {
                                Text(self.note.text)
                            }
                        }
                        .font(.system(.subheadline,
                                      design: self.note.fontDesign.value,
                                      weight: self.note.fontWeight.value))
                        .italic(self.note.italic)
                        .multilineTextAlignment(self.note.multilineTextAlignment.value)
                        .padding(8)
                        .animation(.default, value: self.note.fontWeight)
                        .animation(.default, value: self.note.fontDesign)
                        .animation(.default, value: self.note.italic)
                        .animation(.default, value: self.note.multilineTextAlignment)
                    }
                    .frame(width: 240, height: 100)
                    Text("Preview")
                        .foregroundStyle(.secondary)
                        .tracking(0.5)
                        .font(.subheadline.italic().weight(.light))
                }
                Spacer()
            }
            .padding(.top)
            .listRowBackground(Color.clear)
        }
    }
}

private struct 🎚️EmptyIconMenuLink: View {
    @EnvironmentObject var note: 📝NoteModel
    var body: some View {
        NavigationLink {
            List {
                🎚️EmptyIconPreview()
                Section {
                    🎚️EmptyTypePicker()
                    if self.note.empty_type == .userText {
                        🎚️EmptyTextField()
                            .textFieldStyle(.roundedBorder)
                    }
                }
                .listRowSeparator(.hidden)
                if self.note.empty_type != .nothing {
                    Section { 🎚️EmptyIconSizePicker() }
                }
            }
            .navigationTitle("Empty icon")
            .animation(.default, value: self.note.empty_type)
        } label: {
            Label("Empty icon", systemImage: "questionmark")
        }
    }
}

private struct 🎚️SystemWidgetMenuLink: View {
    @EnvironmentObject var note: 📝NoteModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        Section {
            NavigationLink {
                List {
                    Section { 🎚AppearanceModePicker() }
                    🎚️SystemWidgetPreview()
                    Section {
                        🎚️FontSizeStepper(value: self.$note.system_fontSize)
                        🎚️PaddingStepper()
                        🎚️ContentAlignmentPicker()
                        switch self.note.system_appearanceMode {
                            case .standard:
                                🎚HierarchicalPicker(value: self.$note.system_hierarchical)
                            case .color:
                                🎚️TextColorPicker()
                                🎚️BackgroundColorPicker()
                                🎚️BackgroundGradientToggle()
                        }
                    }
                    NavigationLink {
                        List { 🎚️DoubleSizeOnLargeWidgetToggle() }
                            .navigationTitle("More")
                    } label: {
                        Label("More", systemImage: "ellipsis")
                    }
                    Section { Self.about() }
                }
                .navigationTitle("System widget")
                .animation(.default, value: self.note.system_appearanceMode)
            } label: {
                if self.horizontalSizeClass == .compact {
                    VStack {
                        HStack {
                            Self.label()
                            Spacer()
                        }
                        Self.exampleImage()
                    }
                } else {
                    HStack {
                        Self.label()
                        Spacer()
                        Self.exampleImage()
                    }
                }
            }
        }
    }
    private static func label() -> some View {
        Label("System widget", systemImage: "slider.horizontal.3")
    }
    private static func exampleImage() -> some View {
        Image(.homeScreenExample)
            .resizable()
            .scaledToFit()
            .frame(width: 180)
            .shadow(radius: 2, y: 1)
            .padding(8)
    }
    private static func about() -> some View {
        VStack(alignment: .leading) {
            Text("・Home screen")
            Text("・Notification center")
            Text("・StandBy")
            Text("・Desktop")
            Text("・Lock screen(iPad)")
        }
        .font(.subheadline)
        .foregroundStyle(.secondary)
        .frame(maxWidth: .infinity)
        .listRowBackground(Color.clear)
    }
}

private struct 🎚️AccessoryWidgetMenuLink: View {
    @EnvironmentObject var note: 📝NoteModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        Section {
            NavigationLink {
                List {
                    🎚️AccessoryWidgetPreview()
                    Section {
                        🎚️FontSizeStepper(value: self.$note.accessory_fontSize)
                        🎚HierarchicalPicker(value: self.$note.accessory_hierarchical)
                    }
                    if #unavailable(iOS 17.0) {
                        NavigationLink {
                            List { 🎚️AccessaryCircularBackgroundToggleForIOS16AndWatchOS() }
                                .navigationTitle("More")
                        } label: {
                            Label("More", systemImage: "ellipsis")
                        }
                    }
                    Self.about()
                }
                .navigationTitle("Accessory widget")
            } label: {
                if self.horizontalSizeClass == .compact {
                    VStack {
                        HStack {
                            Self.label()
                            Spacer()
                        }
                        Self.exampleImage()
                    }
                } else {
                    HStack {
                        Self.label()
                        Spacer()
                        Self.exampleImage()
                    }
                }
            }
        }
    }
    private static func label() -> some View {
        Label("Accessory widget", systemImage: "slider.horizontal.3")
    }
    private static func exampleImage() -> some View {
        Image(.lockScreenExample)
            .resizable()
            .scaledToFit()
            .frame(width: 180)
            .shadow(radius: 2, y: 1)
            .padding(8)
    }
    private static func about() -> some View {
        VStack(alignment: .leading) {
            Text("・Lock screen")
            Text("・Apple Watch complication")
        }
        .font(.subheadline)
        .foregroundStyle(.secondary)
        .frame(maxWidth: .infinity)
        .listRowBackground(Color.clear)
    }
}
