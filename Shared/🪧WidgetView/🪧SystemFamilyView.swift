import SwiftUI

struct 🪧SystemFamilyView: View {
    @EnvironmentObject var note: 📝NoteModel
    @Environment(\.widgetFamily) var widgetFamily
    @Environment(\.ⓢituation) var situation
    var body: some View {
        ZStack(alignment: self.note.system_contentAlignment.value) {
            Self.Background()
            Group {
                if self.note.text.isEmpty {
                    if self.situation == .previewInApp {
                        🪧SampleTextInApp()
                            .font(self.font)
                    } else {
                        🪧EmptyIconView()
                    }
                } else {
                    Text(self.note.text)
                        .font(self.font)
                }
            }
            .modifier(Self.ForegroundStyle())
            .italic(self.note.system_italic)
            .multilineTextAlignment(self.note.system_multilineTextAlignment.value)
            .padding(self.padding)
        }
        .modifier(Self.Animation())
    }
}

private extension 🪧SystemFamilyView {
    private var font: Font {
        .system(size: CGFloat(self.note.system_fontSize * self.scale),
                weight: self.note.system_fontWeight.value,
                design: self.note.system_fontDesign.value)
    }
    private var padding: CGFloat { .init(self.note.system_padding * self.scale) }
    private var scale: Int {
        switch self.widgetFamily {
            case .systemLarge, .systemExtraLarge: self.note.system_doubleSizeOnLargeWidget ? 2 : 1
            default: 1
        }
    }
    private struct Background: View {
        @EnvironmentObject var note: 📝NoteModel
        @Environment(\.widgetRenderingMode) var widgetRenderingMode
        var body: some View {
            switch self.note.system_appearanceMode {
                case .standard:
                    if #available(iOS 17.0, watchOS 10.0, macOS 14.0, *) {
                        Rectangle()
                            .fill(.background)
                            .modifier(Self.ContainerBackgroundRemover())
                    } else {
                        Rectangle()
                            .fill(.background)
                    }
                case .color:
                    switch self.widgetRenderingMode {
                        case .fullColor:
                            if self.note.system_backgroundGradient {
                                Rectangle()
                                    .fill(self.note.system_backgroundColor.gradient)
                            } else {
                                self.note.system_backgroundColor
                            }
                        case .vibrant, .accented:
                            if #available(iOS 17.0, watchOS 10.0, macOS 14.0, *) {
                                Rectangle()
                                    .fill(.background)
                                    .modifier(Self.ContainerBackgroundRemover())
                            } else {
                                Color.clear
                            }
                        default:
                            Color.clear
                    }
            }
        }
        @available(iOS 17.0, watchOS 10.0, macOS 14.0, *)
        private struct ContainerBackgroundRemover: ViewModifier {
            @Environment(\.showsWidgetContainerBackground) var showsWidgetContainerBackground
            func body(content: Content) -> some View {
                if self.showsWidgetContainerBackground {
                    content
                } else {
                    Color.clear
                }
            }
        }
    }
    private struct ForegroundStyle: ViewModifier {
        @EnvironmentObject var note: 📝NoteModel
        @Environment(\.widgetRenderingMode) var widgetRenderingMode
        func body(content: Content) -> some View {
            switch self.note.system_appearanceMode {
                case .standard:
                    content.foregroundStyle(self.note.system_hierarchical.value)
                case .color:
                    switch self.widgetRenderingMode {
                        case .vibrant, .accented:
                            content.foregroundStyle(self.note.system_hierarchical.value)
                        default:
                            content.foregroundStyle(self.note.system_textColor)
                    }
            }
        }
    }
    private struct Animation: ViewModifier {
        @EnvironmentObject var note: 📝NoteModel
        @Environment(\.ⓢituation) var situation
        func body(content: Content) -> some View {
            if self.situation == .previewInApp {
                content
                    .animation(.default, value: self.note.system_fontSize)
                    .animation(.default, value: self.note.system_fontDesign)
                    .animation(.default, value: self.note.system_fontWeight)
                    .animation(.default, value: self.note.system_hierarchical)
                    .animation(.default, value: self.note.system_multilineTextAlignment)
                    .animation(.default, value: self.note.system_italic)
                    .animation(.default, value: self.note.system_padding)
                    .animation(.default, value: self.note.system_contentAlignment)
                    .animation(.default, value: self.note.system_textColor)
                    .animation(.default, value: self.note.system_backgroundColor)
                    .animation(.default, value: self.note.system_backgroundGradient)
            } else {
                content
            }
        }
    }
}
