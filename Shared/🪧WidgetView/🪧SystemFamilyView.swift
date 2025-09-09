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
            .italic(self.note.italic)
            .multilineTextAlignment(self.note.multilineTextAlignment.value)
            .padding(self.padding)
        }
        .modifier(Self.Animation())
    }
}

private extension 🪧SystemFamilyView {
    private var font: Font {
        .system(size: CGFloat(self.note.system_fontSize * self.scale),
                weight: self.note.fontWeight.value,
                design: self.note.fontDesign.value)
    }
    private var padding: CGFloat { .init(self.note.system_padding * self.scale) }
    private var scale: Int {
        let isLarge = {
            switch self.widgetFamily {
                case .systemLarge, .systemExtraLarge: true
#if os(visionOS)
                case .systemExtraLargePortrait: true
#endif
                default: false
            }
        }()
        return isLarge && self.note.system_doubleSizeOnLargeWidget ? 2 : 1
    }
    private struct Background: View {
        @EnvironmentObject var note: 📝NoteModel
        @Environment(\.widgetRenderingMode) var widgetRenderingMode
        @Environment(\.showsWidgetContainerBackground) var showsWidgetContainerBackground
        var body: some View {
            Group {
                switch self.note.system_appearanceMode {
                    case .standard:
                        Rectangle()
                            .fill(.background)
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
                                Rectangle()
                                    .fill(.background)
                            default:
                                Color.clear
                        }
                }
            }
            .opacity(self.showsWidgetContainerBackground ? 1 : 0)
            .opacity(self.isInactiveDesktopOnMacOS14 ? 0 : 1)
            .opacity(self.isFullColorOnVisionOS ? 1 : 0)
        }
        private var isInactiveDesktopOnMacOS14: Bool {
            #if os(macOS)
            if #available(macOS 14.0, *) {
                self.widgetRenderingMode != .fullColor
            } else {
                false
            }
            #else
            false
            #endif
        }
        private var isFullColorOnVisionOS: Bool {
#if os(visionOS)
            self.widgetRenderingMode == .fullColor
#else
            true
#endif
        }
    }
    private struct ForegroundStyle: ViewModifier {
        @EnvironmentObject var note: 📝NoteModel
        @Environment(\.showsWidgetContainerBackground) var showsWidgetContainerBackground
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
                            if self.showsWidgetContainerBackground {
                                content.foregroundStyle(self.note.system_textColor)
                            } else {
                                content.foregroundStyle(self.note.system_hierarchical.value)
                            }
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
                    .animation(.default, value: self.note.fontDesign)
                    .animation(.default, value: self.note.fontWeight)
                    .animation(.default, value: self.note.italic)
                    .animation(.default, value: self.note.multilineTextAlignment)
                    .animation(.default, value: self.note.system_fontSize)
                    .animation(.default, value: self.note.system_hierarchical)
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
