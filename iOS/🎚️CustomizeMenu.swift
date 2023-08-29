import SwiftUI

struct 🎚️CustomizeMenu: View {
    @EnvironmentObject var note: 📝NoteModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            List {
                🎚️SystemWidgetMenuLink()
                🎚️AccessoryWidgetMenuLink()
                🎚️EmptyIconMenuLink()
            }
            .navigationTitle("Customize \"\(self.note.title)\"")
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

private struct 🎚️SystemWidgetMenuLink: View {
    @EnvironmentObject var note: 📝NoteModel
    var body: some View {
        Section {
            NavigationLink {
                List {
                    Section { 🎚AppearanceModePicker() }
                    🎚️SystemWidgetPreview()
                    Section {
                        🎚️FontSizeStepper(value: self.$note.system_fontSize)
                        🎚FontWeightPicker(value: self.$note.system_fontWeight)
                        🎚FontDesignPicker(value: self.$note.system_fontDesign)
                        🎚MultilineTextAlignmentPicker(value: self.$note.system_multilineTextAlignment)
                        🎚ItalicToggle(value: self.$note.system_italic)
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
                }
                .navigationTitle("System widget")
                .animation(.default, value: self.note.system_appearanceMode)
            } label: {
                HStack {
                    Text("System widget")
                    Spacer()
                    Image(.homeScreenExample)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180)
                        .shadow(radius: 2, y: 1)
                        .padding(.vertical, 12)
                }
                .font(.title3.bold())
            }
        } footer: {
            Text("Home screen, Notification center, StandBy, Desktop, Lock screen(iPad)")
        }
    }
}

private struct 🎚️AccessoryWidgetMenuLink: View {
    @EnvironmentObject var note: 📝NoteModel
    var body: some View {
        Section {
            NavigationLink {
                List {
                    🎚️AccessoryWidgetPreview()
                    Section {
                        🎚️FontSizeStepper(value: self.$note.accessory_fontSize)
                        🎚FontWeightPicker(value: self.$note.accessory_fontWeight)
                        🎚FontDesignPicker(value: self.$note.accessory_fontDesign)
                        🎚MultilineTextAlignmentPicker(value: self.$note.accessory_multilineTextAlignment)
                        🎚ItalicToggle(value: self.$note.accessory_italic)
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
                }
                .navigationTitle("Accessory widget")
            } label: {
                HStack {
                    Text("Accessory widget")
                    Spacer()
                    Image(.lockScreenExample)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180)
                        .shadow(radius: 2)
                        .padding(.vertical, 8)
                }
                .font(.title3.bold())
            }
        } footer: {
            Text("Lock screen, Apple Watch complication")
        }
    }
}

private struct 🎚️EmptyIconMenuLink: View {
    @EnvironmentObject var note: 📝NoteModel
    var body: some View {
        Section {
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
