import SwiftUI
import WidgetKit

struct 💁WidgetGuideTab: View {
    var body: some View {
        NavigationStack {
            List {
                Text("""
                1. Touch and hold the Lock Screen until the Customize button appears, then tap Customize.
                2. Select Lock Screen.
                3. Tap Add Widgets.
                4. Tap or drag the widgets that you want to add to the Lock Screen.
                5. When you're finished, tap the close button, then tap Done.
                """)
                Link(destination: URL(string: "https://support.apple.com/HT207122")!) {
                    Label("Apple Support page", systemImage: "link")
                }
            }
            .navigationTitle("How to add widgets")
        }
    }
}
