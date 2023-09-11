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
            .modifier(Self.SmartStackPadding())
        }
        .font(.system(size: CGFloat(self.note.accessory_fontSize),
                      weight: self.note.fontWeight.value,
                      design: self.note.fontDesign.value))
        .italic(self.note.italic)
        .multilineTextAlignment(self.note.multilineTextAlignment.value)
        .foregroundStyle(self.note.accessory_hierarchical.value)
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
    private struct SmartStackPadding: ViewModifier {
        @EnvironmentObject var note: 📝NoteModel
        @Environment(\.ⓢituation) var situation
        @Environment(\.widgetRenderingMode) var widgetRenderingMode
        @Environment(\.showsWidgetContainerBackground) var showsWidgetContainerBackground
        private var isSmartStackOnWatchOS10: Bool {
#if os(watchOS)
            if #available(watchOS 10.0, *),
               self.showsWidgetContainerBackground,
               self.widgetRenderingMode == .fullColor {
                true
            } else {
                false
            }
#else
            false
#endif
        }
        func body(content: Content) -> some View {
            if self.situation == .previewInApp {
                content
            } else {
                if self.isSmartStackOnWatchOS10 {
                    content.padding(9)
                } else {
                    content
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
                    .animation(.default, value: self.note.accessory_fontSize)
                    .animation(.default, value: self.note.accessory_hierarchical)
            } else {
                content
            }
        }
    }
}
