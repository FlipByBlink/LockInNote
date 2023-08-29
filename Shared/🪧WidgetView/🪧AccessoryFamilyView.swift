import SwiftUI
import WidgetKit

struct 🪧AccessoryFamilyView: View {
    @EnvironmentObject var note: 📝NoteModel
    @Environment(\.ⓢituation) var situation
    var body: some View {
        ZStack {
            Self.Background()
            Group {
                if self.note.text.isEmpty {
                    if self.situation == .previewInApp {
                        🪧SampleTextInApp()
                    } else {
                        🪧EmptyIconView()
                    }
                } else {
                    Text(self.note.text)
                }
            }
            .widgetAccentable()
        }
        .font(.system(size: CGFloat(self.note.accessory_fontSize),
                      weight: self.note.accessory_fontWeight.value,
                      design: self.note.accessory_fontDesign.value))
        .italic(self.note.accessory_italic)
        .multilineTextAlignment(self.note.accessory_multilineTextAlignment.value)
        .modifier(Self.ForegroundStyle())
        .modifier(Self.Animation())
    }
}

private extension 🪧AccessoryFamilyView {
    private struct Background: View {
        @EnvironmentObject var note: 📝NoteModel
        @Environment(\.widgetFamily) var widgetFamily
        @Environment(\.ⓢituation) var situation
        private var condition: Bool {
#if os(watchOS) || os(iOS)
            self.widgetFamily == .accessoryCircular
            && self.note.accessoryCircular_backgroundForIOS16AndWatchOS
            && self.situation != .previewInApp
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
    }
    private struct ForegroundStyle: ViewModifier {
        @EnvironmentObject var note: 📝NoteModel
        @Environment(\.ⓢituation) var situation
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
            if self.situation == .previewInApp {
                content.foregroundStyle(self.note.accessory_hierarchical.value)
            } else {
                if self.isSmartStackOnWatchOS10 {
                    content.foregroundStyle(.black)
                } else {
                    content.foregroundStyle(self.note.accessory_hierarchical.value)
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
                    .animation(.default, value: self.note.accessory_fontSize)
                    .animation(.default, value: self.note.accessory_fontDesign)
                    .animation(.default, value: self.note.accessory_fontWeight)
                    .animation(.default, value: self.note.accessory_hierarchical)
                    .animation(.default, value: self.note.accessory_multilineTextAlignment)
                    .animation(.default, value: self.note.accessory_italic)
            } else {
                content
            }
        }
    }
}
