import WidgetKit
import SwiftUI

struct 🖼️RectangularView : View {
    private let model: 🎛RectangularWidgetModel = .load() ?? .default
    var body: some View {
        Group {
            if self.model.text != "" {
                Text(self.model.text)
                    .italic(self.model.italic)
                    .multilineTextAlignment(self.model.multilineTextAlignment.value)
            } else if self.model.placeholder != .nothing {
                Image(systemName: self.model.placeholder.icon)
                    .imageScale(.large)
            }
        }
        .font(.system(size: CGFloat(self.model.fontSize),
                      weight: self.model.fontWeight.value,
                      design: self.model.fontDesign.value))
        .foregroundStyle(self.model.level.value)
        .widgetAccentable()
        .widgetURL(🔗WidgetLink.rectangular.url)
        .modifier(🖼️ContainerBackground())
    }
}

struct 🖼️CircularView : View {
    private let model: 🎛CircularWidgetModel = .load() ?? .default
    var body: some View {
        Group {
            if self.model.text != "" {
                ZStack {
                    if self.model.background { AccessoryWidgetBackground() }
                    Text(self.model.text)
                        .italic(self.model.italic)
                        .multilineTextAlignment(self.model.multilineTextAlignment.value)
                        .padding(.horizontal, 2)
                }
            } else {
                ZStack {
                    if self.model.background { AccessoryWidgetBackground() }
                    if self.model.placeholder != .nothing {
                        Image(systemName: self.model.placeholder.icon)
                            .imageScale(.large)
                    }
                }
            }
        }
        .font(.system(size: CGFloat(self.model.fontSize),
                      weight: self.model.fontWeight.value,
                      design: self.model.fontDesign.value))
        .foregroundStyle(self.model.level.value)
        .widgetAccentable()
        .widgetURL(🔗WidgetLink.circular.url)
        .modifier(🖼️ContainerBackground())
    }
}

struct 🖼️InlineView : View {
    private let model: 🎛InlineWidgetModel = .load() ?? .default
    var body: some View {
        Group {
            if self.model.text != "" {
                Text(self.model.text)
            } else if self.model.placeholder != .nothing {
                Image(systemName: self.model.placeholder.icon)
            }
        }
        .widgetAccentable()
        .widgetURL(🔗WidgetLink.inline.url)
        .modifier(🖼️ContainerBackground())
    }
}

private struct 🖼️ContainerBackground: ViewModifier { //WIP
    func body(content: Content) -> some View {
        #if os(iOS)
        if #available(iOS 17.0, *) {
            content
                .containerBackground(.clear, for: .widget)
        } else {
            content
        }
        #else
        if #available(watchOS 10.0, *) {
            content
                .containerBackground(.clear, for: .widget)
        } else {
            content
        }
        #endif
    }
}
