import SwiftUI

@main
struct 🪧WidgetBundle: WidgetBundle {
    var body: some Widget {
        🪧PrimaryWidget()
        🪧SecondaryWidget()
        🪧TertiaryWidget()
    }
    init() {
        #if os(iOS) || os(watchOS)
        🗄️MigrationFromVer_1_1.execute()
        #endif
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
