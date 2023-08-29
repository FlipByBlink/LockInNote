import SwiftUI
import WidgetKit

struct 🪧AccessoryFamilyView: View {
    @EnvironmentObject var note: 📝NoteModel
    private var isPreviewInApp: Bool = false
    var body: some View {
        ZStack {
            Self.Background(self.isPreviewInApp)
            if self.note.text.isEmpty {
                if self.isPreviewInApp {
                    🪧SampleTextInApp()
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
        .modifier(Self.ForegroundStyle(self.isPreviewInApp))
        .modifier(Self.Animation(self.isPreviewInApp))
    }
    init(isPreview: Bool = false) {
        self.isPreviewInApp = isPreview
    }
}

private extension 🪧AccessoryFamilyView {
    private struct Background: View {
        @EnvironmentObject var note: 📝NoteModel
        @Environment(\.widgetFamily) var widgetFamily
        var isPreviewInApp: Bool
        private var condition: Bool {
#if os(watchOS) || os(iOS)
            self.widgetFamily == .accessoryCircular
            && self.note.accessoryCircular_backgroundForIOS16AndWatchOS
            && !self.isPreviewInApp
#else
            false
#endif
        }
        var body: some View {
            ZStack {
                Color.clear
                if self.condition {
#if os(watchOS)
                    AccessoryWidgetBackground()
#elseif os(iOS)
                    if #unavailable(iOS 17.0) { AccessoryWidgetBackground() }
#endif
                }
            }
        }
        init(_ isPreviewInApp: Bool) {
            self.isPreviewInApp = isPreviewInApp
        }
    }
    private struct ForegroundStyle: ViewModifier {
        @EnvironmentObject var note: 📝NoteModel
        private var isPreviewInApp: Bool
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
            if self.isPreviewInApp {
                content.foregroundStyle(self.note.accessory_hierarchical.value)
            } else {
                if self.isSmartStackOnWatchOS10 {
                    content.foregroundStyle(.black)
                } else {
                    content.foregroundStyle(self.note.accessory_hierarchical.value)
                }
            }
        }
        init(_ isPreviewInApp: Bool) {
            self.isPreviewInApp = isPreviewInApp
        }
    }
    private struct Animation: ViewModifier {
        @EnvironmentObject var note: 📝NoteModel
        private var isPreviewInApp: Bool
        func body(content: Content) -> some View {
            content
                .animation(.default, value: self.note.accessory_fontSize)
                .animation(.default, value: self.note.accessory_fontDesign)
                .animation(.default, value: self.note.accessory_fontWeight)
                .animation(.default, value: self.note.accessory_hierarchical)
                .animation(.default, value: self.note.accessory_multilineTextAlignment)
                .animation(.default, value: self.note.accessory_italic)
        }
        init(_ isPreviewInApp: Bool) {
            self.isPreviewInApp = isPreviewInApp
        }
    }
}
