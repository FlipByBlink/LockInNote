import SwiftUI

struct 🎚️CustomizeMenu: View {
    @EnvironmentObject var note: 📝NoteModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            List {
                Self.SharedOptionSection()
                Self.SystemWidgetMenuLink()
#if os(iOS)
                Self.AccessoryWidgetMenuLink()
#endif
                Self.TitleTextFieldLink()
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
    private struct SharedOptionSection: View {
        @EnvironmentObject var note: 📝NoteModel
        var body: some View {
            Self.Preview()
            Section {
                🎚FontWeightPicker()
                🎚FontDesignPicker()
                🎚ItalicToggle()
                🎚MultilineTextAlignmentPicker()
                Self.EmptyIconMenuLink()
            }
        }
        private struct Preview: View {
            @EnvironmentObject var note: 📝NoteModel
            var body: some View {
                HStack {
                    Spacer()
                    VStack(spacing: 4) {
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
                            .font(.caption.italic().weight(.light))
                    }
                    Spacer()
                }
                .padding(.top)
                .listRowBackground(Color.clear)
            }
        }
        private struct EmptyIconMenuLink: View {
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
    }
    private struct SystemWidgetMenuLink: View {
        @EnvironmentObject var note: 📝NoteModel
        @Environment(\.horizontalSizeClass) var horizontalSizeClass
        var body: some View {
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
                        NavigationLink {
                            List { 🎚️DoubleSizeOnLargeWidgetToggle() }
                                .navigationTitle("More")
                        } label: {
                            Label("More", systemImage: "ellipsis")
                        }
                    }
                    Self.about()
                }
                .navigationTitle("System widget")
                .animation(.default, value: self.note.system_appearanceMode)
            } label: {
                LabeledContent {
                    Image(.homeScreenExample)
                        .resizable()
                        .scaledToFit()
                        .frame(width: self.horizontalSizeClass == .compact ? 120 : 180)
                        .shadow(radius: 2, y: 1)
                        .padding(8)
                } label: {
                    Label(self.horizontalSizeClass == .compact ? "System\nwidget" : "System widget",
                          systemImage: "slider.horizontal.3")
                }
            }
        }
        private static func about() -> some View {
            Text("""
        __Target__
        Home screen
        Notification center
        StandBy
        Desktop
        Lock screen(iPad)
        """)
            .multilineTextAlignment(.center)
            .font(.caption)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity)
            .listRowBackground(Color.clear)
        }
    }
#if os(iOS)
    private struct AccessoryWidgetMenuLink: View {
        @EnvironmentObject var note: 📝NoteModel
        @Environment(\.horizontalSizeClass) var horizontalSizeClass
        var body: some View {
            NavigationLink {
                List {
                    🎚️AccessoryWidgetPreview()
                    Section {
                        🎚️FontSizeStepper(value: self.$note.accessory_fontSize)
                        🎚HierarchicalPicker(value: self.$note.accessory_hierarchical)
                        if #unavailable(iOS 17.0) {
                            NavigationLink {
                                List { 🎚️AccessaryCircularBackgroundToggleForIOS16AndWatchOS() }
                                    .navigationTitle("More")
                            } label: {
                                Label("More", systemImage: "ellipsis")
                            }
                        }
                    }
                    Self.about()
                }
                .navigationTitle("Accessory widget")
            } label: {
                LabeledContent {
                    Image(.lockScreenExample)
                        .resizable()
                        .scaledToFit()
                        .frame(width: self.horizontalSizeClass == .compact ? 120 : 180)
                        .shadow(radius: 2, y: 1)
                        .padding(8)
                } label: {
                    Label(self.horizontalSizeClass == .compact ? "Accessory\nwidget" : "Accessory widget",
                          systemImage: "slider.horizontal.3")
                }
            }
        }
        private static func about() -> some View {
            Text("""
        __Target__
        Lock screen
        Apple Watch complication
        """)
            .multilineTextAlignment(.center)
            .font(.caption)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity)
            .listRowBackground(Color.clear)
        }
    }
#endif
    private struct TitleTextFieldLink: View {
        @EnvironmentObject var note: 📝NoteModel
        var body: some View {
            Section {
                NavigationLink {
                    List {
                        🎚️TitleTextField()
                            .textFieldStyle(.roundedBorder)
                    }
                    .navigationTitle("Widget title")
                } label: {
                    LabeledContent {
                        Text(self.note.title)
                    } label: {
                        Label("Widget title", systemImage: "tag")
                    }
                }
            }
        }
    }
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
