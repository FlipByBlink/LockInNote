import SwiftUI

struct 🪧EmptyIconView: View {
    @EnvironmentObject var note: 📝NoteModel
    @Environment(\.widgetFamily) var widgetFamily
    var body: some View {
        switch self.widgetFamily {
#if !os(visionOS)
            case .accessoryInline:
                self.icon()
#endif
            default:
                GeometryReader { ⓟroxy in
                    ZStack {
                        Color.clear
                        self.icon()
                            .font(.system(size: self.fontSize(ⓟroxy),
                                          weight: self.note.fontWeight.value,
                                          design: self.note.fontDesign.value))
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                    }
                }
                .modifier(Self.Animation())
        }
    }
}

private extension 🪧EmptyIconView {
    private func icon() -> some View {
        Group {
            switch self.note.empty_type {
                case .squareAndPencil, .ellipsis, .pencil:
                    Image(systemName: self.note.empty_type.icon)
                case .userText:
                    if self.note.empty_userText.isEmpty {
                        Text("Empty")
                    } else {
                        Text(self.note.empty_userText)
                    }
                case .nothing:
                    EmptyView()
            }
        }
    }
    private func fontSize(_ ⓟroxy: GeometryProxy) -> CGFloat {
        var value = self.note.empty_iconSize.value
        value *= min(ⓟroxy.size.width,
                     ⓟroxy.size.height)
        value *= self.isLargeFamily ? 0.8 : 1
        return value
    }
    private var isLargeFamily: Bool {
        #if os(iOS)
        [.systemLarge, .systemExtraLarge].contains(self.widgetFamily)
        #elseif os(visionOS)
        [.systemLarge, .systemExtraLarge, .systemExtraLargePortrait]
            .contains(self.widgetFamily)
        #elseif os(macOS)
        [.systemLarge].contains(self.widgetFamily)
        #elseif os(watchOS)
        false
        #endif
    }
    private struct Animation: ViewModifier {
        @EnvironmentObject var note: 📝NoteModel
        @Environment(\.ⓢituation) var situation
        func body(content: Content) -> some View {
            if self.situation == .previewInApp {
                content
                    .animation(.default, value: self.note.empty_type)
                    .animation(.default, value: self.note.empty_iconSize)
            } else {
                content
            }
        }
    }
}
