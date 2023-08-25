import SwiftUI

@main
struct 🪧WidgetBundle: WidgetBundle {
    var body: some Widget {
        🪧PrimaryWidget()
        🪧SecondaryWidget()
        🪧TertiaryWidget()
    }
}

private struct 🪧PrimaryWidget: Widget {
    var body: some WidgetConfiguration {
        🪧WidgetConfiguration(noteFamily: .primary)
    }
}

private struct 🪧SecondaryWidget: Widget {
    var body: some WidgetConfiguration {
        🪧WidgetConfiguration(noteFamily: .secondary)
    }
}

private struct 🪧TertiaryWidget: Widget {
    var body: some WidgetConfiguration {
        🪧WidgetConfiguration(noteFamily: .tertiary)
    }
}