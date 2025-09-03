import SwiftUI

struct 🎚️SharedOptionPreview: View {
    @EnvironmentObject var note: 📝NoteModel
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 4) {
                ZStack(alignment: self.alignment) {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(.gray.opacity(0.5).gradient)
                    Group {
                        if self.note.text.isEmpty {
                            Text(verbatim: "This is a placeholder.\nこれは仮の文章です。\n이것은 플레이스 홀더입니다.")
                        } else {
                            Text(self.note.text)
                        }
                    }
                    .font(.system(size: self.fontSize,
                                  weight: self.note.fontWeight.value,
                                  design: self.note.fontDesign.value))
                    .italic(self.note.italic)
                    .multilineTextAlignment(self.note.multilineTextAlignment.value)
                    .padding(self.paddingSize)
                    .animation(.default, value: self.note.fontWeight)
                    .animation(.default, value: self.note.fontDesign)
                    .animation(.default, value: self.note.italic)
                    .animation(.default, value: self.note.system_fontSize)
                    .animation(.default, value: self.note.system_padding)
                }
                .frame(width: 180, height: 180)
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

private extension 🎚️SharedOptionPreview {
    private var alignment: Alignment {
#if os(iOS)
        .center
#elseif os(visionOS)
        self.note.system_contentAlignment.value
#endif
    }
    private var fontSize: CGFloat {
#if os(iOS)
        15
#elseif os(visionOS)
        CGFloat(self.note.system_fontSize)
#endif
    }
    private var paddingSize: CGFloat {
#if os(iOS)
        8
#elseif os(visionOS)
        CGFloat(self.note.system_padding)
#endif
    }
}
