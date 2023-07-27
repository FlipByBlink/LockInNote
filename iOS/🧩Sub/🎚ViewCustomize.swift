import SwiftUI

struct 🎚CustomizeFontLink<T: 🄵ontOptions>: View {
    @Binding private var fontOptions: T
    var body: some View {
        NavigationLink {
            VStack(spacing: 0) {
                GroupBox {
                    Text(verbatim: """
                        This is sample.
                        これは仮の文章です。
                        이것은 플레이스 홀더입니다.
                        """)
                    .font(.system(size: CGFloat(self.fontOptions.fontSize),
                                  weight: self.fontOptions.fontWeight.value,
                                  design: self.fontOptions.fontDesign.value))
                    .italic(self.fontOptions.italic)
                    .foregroundStyle(self.fontOptions.level.value)
                    .multilineTextAlignment(self.fontOptions.multilineTextAlignment.value)
                }
                .padding()
                .padding(.horizontal)
                .padding(.top, 8)
                .animation(.default, value: self.fontOptions.multilineTextAlignment)
                List {
                    Section {
                        🎚WeightPicker(self.$fontOptions.fontWeight)
                        🎚DesignPicker(self.$fontOptions.fontDesign)
                        🎚FontSizePicker(self.$fontOptions.fontSize)
                        🎚LevelPicker(self.$fontOptions.level)
                        🎚TextAlignmentPicker(self.$fontOptions.multilineTextAlignment)
                        🎚ItalicPicker(self.$fontOptions.italic)
                    } header: {
                        Text("Option")
                    }
                }
                .listStyle(.plain)
            }
            .navigationBarTitle("Customize font")
        } label: {
            Label("Customize font", systemImage: "slider.horizontal.3")
                .padding(.vertical, 6)
        }
    }
    init(_ fontOptions: Binding<T>) {
        self._fontOptions = fontOptions
    }
}

struct 🎚PlaceholderPicker: View {//Blank icon
    @Binding var placeholder: 🄿laceholder
    var body: some View {
        Picker(selection: self.$placeholder) {
            ForEach(🄿laceholder.allCases) { ⓒase in
                Label(LocalizedStringKey(ⓒase.rawValue), systemImage: ⓒase.icon)
                    .labelStyle(.iconOnly)
            }
        } label: {
            Label("Blank icon", systemImage: "questionmark")
                .strikethrough(self.placeholder == .nothing)
        }
    }
    init(_ placeholder: Binding<🄿laceholder>) {
        self._placeholder = placeholder
    }
}

struct 🎚WeightPicker: View {
    @Binding var value: 🅆eight
    var body: some View {
        HStack {
            🎚OptionIcon(name: "bold")
            Picker("Weight", selection: self.$value) {
                ForEach(🅆eight.allCases) { ⓒase in
                    Text(LocalizedStringKey(ⓒase.rawValue))
                        .fontWeight(ⓒase.value)
                }
            }
            .pickerStyle(.navigationLink)
        }
    }
    init(_ value: Binding<🅆eight>) {
        self._value = value
    }
}

struct 🎚DesignPicker: View {
    @Binding var value: 🄳esign
    var body: some View {
        HStack {
            🎚OptionIcon(name: "a.magnify")
            Picker("Design", selection: self.$value) {
                ForEach(🄳esign.allCases) { ⓒase in
                    Text(LocalizedStringKey(ⓒase.rawValue))
                        .font(.system(.body, design: ⓒase.value))
                }
            }
            .pickerStyle(.navigationLink)
        }
    }
    init(_ value: Binding<🄳esign>) {
        self._value = value
    }
}

struct 🎚FontSizePicker: View {
    @Binding var value: Int
    var body: some View {
        HStack {
            🎚OptionIcon(name: "textformat")
            Picker("Size", selection: self.$value) {
                ForEach(8 ..< 50, id: \.self) { ⓟoint in
                    Text(ⓟoint.description)
                        .font(.system(size: CGFloat(ⓟoint)))
                }
            }
            .pickerStyle(.navigationLink)
        }
    }
    init(_ value: Binding<Int>) {
        self._value = value
    }
}

struct 🎚LevelPicker: View {
    @Binding var value: 🄻evel
    var body: some View {
        HStack {
            🎚OptionIcon(name: "camera.filters")
                .symbolRenderingMode(.hierarchical)
            Picker("Level", selection: self.$value) {
                ForEach(🄻evel.allCases) { ⓒase in
                    Text(LocalizedStringKey(ⓒase.rawValue))
                        .foregroundStyle(ⓒase.value)
                }
            }
            .pickerStyle(.navigationLink)
        }
    }
    init(_ value: Binding<🄻evel>) {
        self._value = value
    }
}

struct 🎚TextAlignmentPicker: View {
    @Binding var value: 🄼ultilineTextAlignment
    var body: some View {
        HStack {
            🎚OptionIcon(name: "text.justify")
            Picker("Multi text alignment", selection: self.$value) {
                ForEach(🄼ultilineTextAlignment.allCases) { ⓒase in
                    Label(LocalizedStringKey(ⓒase.rawValue), systemImage: ⓒase.icon)
                        .labelStyle(.iconOnly)
                }
            }
        }
    }
    init(_ value: Binding<🄼ultilineTextAlignment>) {
        self._value = value
    }
}

struct 🎚ItalicPicker: View {
    @Binding var value: Bool
    var body: some View {
        HStack {
            🎚OptionIcon(name: "italic")
            Toggle(isOn: self.$value) {
                Text("Italic")
            }
        }
    }
    init(_ value: Binding<Bool>) {
        self._value = value
    }
}

private struct 🎚OptionIcon: View {
    var name: String
    var body: some View {
        Image(systemName: self.name)
            .resizable()
            .scaledToFit()
            .frame(width: 16, height: 16)
            .padding(.horizontal, 10)
            .foregroundColor(.accentColor)
    }
}
