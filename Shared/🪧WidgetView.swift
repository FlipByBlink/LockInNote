import SwiftUI
import WidgetKit

struct 🪧EntryView: View {
    var situation: 🪧ViewSituation
    @EnvironmentObject var note: 📝NoteModel
    @Environment(\.widgetFamily) var widgetFamily
    var body: some View {
        Group {
            switch self.widgetFamily {
                case .systemSmall, .systemMedium, .systemLarge, .systemExtraLarge:
                    🪧SystemFamilyView()
                case .accessoryInline, .accessoryCircular, .accessoryRectangular:
                    🪧AccessoryFamilyView()
                #if os(watchOS)
                case .accessoryCorner:
                    🪧AccessoryCornerView()
                #endif
                default:
                    🪧PlaceholderView()
            }
        }
        .modifier(🪧ContainerBackground())
        .widgetURL(self.note.family.widgetURL)
        .modifier(🪧SnapshotTitle(self.situation))
    }
    init(_ situation: 🪧ViewSituation) {
        self.situation = situation
    }
}

enum 🪧ViewSituation {
    case timeline, snapshot, placeholder
}

struct 🪧SystemFamilyView: View {
    @EnvironmentObject var note: 📝NoteModel
    @Environment(\.widgetFamily) var widgetFamily
    var isPreview: Bool = false
    var body: some View {
        ZStack(alignment: self.note.system_contentAlignment.value) {
            Self.Background()
            Group {
                if self.note.text.isEmpty {
                    if self.isPreview {
                        🪧PreviewText()
                    } else {
                        🪧EmptyIconView()
                    }
                } else {
                    Text(self.note.text)
                }
            }
            .modifier(Self.ForegroundStyle())
            .font(.system(size: CGFloat(self.note.system_fontSize * self.scale),
                          weight: self.note.system_fontWeight.value,
                          design: self.note.system_fontDesign.value))
            .italic(self.note.system_italic)
            .multilineTextAlignment(self.note.system_multilineTextAlignment.value)
            .padding(CGFloat(self.note.system_padding * self.scale))
        }
        .modifier(Self.Animation(self.isPreview))
    }
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
                        Rectangle().fill(.background)
                            .modifier(Self.ContainerBackgroundRemove())
                    } else {
                        Rectangle().fill(.background)
                    }
                case .color:
                    switch self.widgetRenderingMode {
                        case .fullColor:
                            if self.note.system_backgroundGradient {
                                Rectangle().fill(self.note.system_backgroundColor.gradient)
                            } else {
                                self.note.system_backgroundColor
                            }
                        case .vibrant, .accented:
                            Color.clear
                        default:
                            Color.clear
                    }
            }
        }
        @available(iOS 17.0, watchOS 10.0, macOS 14.0, *)
        private struct ContainerBackgroundRemove: ViewModifier {
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
        var isPreview: Bool
        func body(content: Content) -> some View {
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
        }
        init(_ isPreview: Bool) {
            self.isPreview = isPreview
        }
    }
}

struct 🪧AccessoryFamilyView: View {
    @EnvironmentObject var note: 📝NoteModel
    var isPreview: Bool = false
    var body: some View {
        ZStack {
            Self.Background()
            if self.note.text.isEmpty {
                if self.isPreview {
                    🪧PreviewText()
                } else {
                    🪧EmptyIconView()
                }
            } else {
                Text(self.note.text)
            }
        }
        .font(.system(size: CGFloat(self.note.accessory_fontSize),
                      weight: self.note.accessory_fontWeight.value,
                      design: self.note.accessory_fontDesign.value))
        .italic(self.note.accessory_italic)
        .multilineTextAlignment(self.note.accessory_multilineTextAlignment.value)
        .widgetAccentable()
        .modifier(Self.ForegroundStyle(self.isPreview))
        .modifier(Self.Animation(self.isPreview))
    }
    private struct Background: View {
        @EnvironmentObject var note: 📝NoteModel
        @Environment(\.widgetFamily) var widgetFamily
        var body: some View {
            ZStack {
                Color.clear
                #if os(iOS) || os(watchOS)
                if #unavailable(iOS 17.0, watchOS 10.0),
                   self.widgetFamily == .accessoryCircular,
                   self.note.accessoryCircular_backgroundForIOS16WatchOS9 {
                    AccessoryWidgetBackground()
                }
                #endif
            }
        }
    }
    private struct ForegroundStyle: ViewModifier {
        @EnvironmentObject var note: 📝NoteModel
        var isPreview: Bool
        @Environment(\.widgetRenderingMode) var widgetRenderingMode
        @Environment(\.showsWidgetContainerBackground) var showsWidgetContainerBackground
        private var isSmartStackOnWatchOS10: Bool {
            #if os(watchOS)
            if #available(watchOS 10.0, *),
               self.showsWidgetContainerBackground,
               self.widgetRenderingMode == .fullColor {
                return true
            } else {
                return false
            }
            #else
            false
            #endif
        }
        func body(content: Content) -> some View {
            if self.isPreview {
                content.foregroundStyle(self.note.accessory_hierarchical.value)
            } else {
                if self.isSmartStackOnWatchOS10 {
                    content.foregroundStyle(.black)
                } else {
                    content.foregroundStyle(self.note.accessory_hierarchical.value)
                }
            }
        }
        init(_ isPreview: Bool) {
            self.isPreview = isPreview
        }
    }
    private struct Animation: ViewModifier {
        @EnvironmentObject var note: 📝NoteModel
        var isPreview: Bool
        func body(content: Content) -> some View {
            content
                .animation(.default, value: self.note.accessory_fontSize)
                .animation(.default, value: self.note.accessory_fontDesign)
                .animation(.default, value: self.note.accessory_fontWeight)
                .animation(.default, value: self.note.accessory_hierarchical)
                .animation(.default, value: self.note.accessory_multilineTextAlignment)
                .animation(.default, value: self.note.accessory_italic)
        }
        init(_ isPreview: Bool) {
            self.isPreview = isPreview
        }
    }
}

#if os(watchOS)
struct 🪧AccessoryCornerView: View {
    @EnvironmentObject var note: 📝NoteModel
    var body: some View {
        Group {
            if self.note.text.isEmpty {
                if self.note.empty_type == .userText {
                    if self.note.empty_userText.isEmpty {
                        Image(systemName: "text.justify.leading")
                            .widgetLabel("Empty")
                    } else {
                        Image(systemName: "text.justify.leading")
                            .widgetLabel(self.note.empty_userText)
                    }
                } else {
                    🪧EmptyIconView()
                }
            } else {
                Image(systemName: "text.justify.leading")
                    .opacity(self.note.empty_type == .nothing ? 0 : 1)
                    .widgetLabel(self.note.text)
            }
        }
        .font(.title3.weight(.semibold))
    }
}
#endif

struct 🪧EmptyIconView: View {
    @EnvironmentObject var note: 📝NoteModel
    var body: some View {
        switch self.note.empty_type {
            case .squareAndPencil, .ellipsis, .pencil:
                Image(systemName: self.note.empty_type.icon)
                    .imageScale(.large)
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

struct 🪧PlaceholderView : View {
    var body: some View {
        VStack {
            Text(verbatim: "AAAAAAAAAAAA")
            Text(verbatim: "AAAAAAAA")
            Text(verbatim: "AAAAAAAAAA")
        }
        .font(.title3)
        .redacted(reason: .placeholder)
        .modifier(🪧ContainerBackground())
    }
}

private struct 🪧ContainerBackground: ViewModifier {
    @Environment(\.widgetRenderingMode) var widgetRenderingMode
    func body(content: Content) -> some View {
        if #available(iOS 17.0, watchOS 10.0, macOS 14.0, *) {
            #if os(watchOS)
            if self.widgetRenderingMode == .fullColor {
                content.containerBackground(.white, for: .widget)
            } else {
                content.containerBackground(.clear, for: .widget)
            }
            #else
            content.containerBackground(.clear, for: .widget)
            #endif
        } else {
            content
        }
    }
}

private struct 🪧SnapshotTitle: ViewModifier {
    @EnvironmentObject var note: 📝NoteModel
    @Environment(\.widgetFamily) var widgetFamily
    var situation: 🪧ViewSituation
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottom) {
                if self.situation == .snapshot {
                    if self.note.title != self.note.family.presetTitle {
                        switch self.widgetFamily {
                            #if os(iOS) || os(macOS)
                            case .systemSmall, .systemMedium, .systemLarge, .systemExtraLarge:
                                Text(self.note.title)
                                    .fontWeight(.semibold)
                                    .padding(8)
                                    .foregroundStyle(.secondary)
                                    .background(.regularMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .padding(8)
                            #endif
                            #if os(iOS) || os(watchOS)
                            case .accessoryCircular, .accessoryRectangular:
                                Text(self.note.title)
                                    .underline()
                                    .foregroundStyle(.secondary)
                                    .font(.caption2.weight(.semibold))
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.6)
                            #endif
                            default:
                                EmptyView()
                        }
                    }
                }
            }
    }
    init(_ situation: 🪧ViewSituation) {
        self.situation = situation
    }
}

private struct 🪧PreviewText: View {
    var body: some View {
        Text(verbatim: "This is sample.\nこれは仮の文章です。\n이것은 플레이스 홀더입니다.")
    }
}
