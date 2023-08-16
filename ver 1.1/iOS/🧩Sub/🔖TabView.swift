import SwiftUI

struct 🔖TabView: View {
    @State private var tab: 🔖Tab = .rectangularWidget
    var body: some View {
        TabView(selection: self.$tab) {
            📝RectangularWidgetTab()
                .tag(🔖Tab.rectangularWidget)
                .tabItem { Label("Rectangular", systemImage: "rectangle.dashed") }
            📝CircularWidgetTab()
                .tag(🔖Tab.circularWidget)
                .tabItem { Label("Circular", systemImage: "circle.dashed") }
            📝InlineWidgetTab()
                .tag(🔖Tab.inlineWidget)
                .tabItem { Label("Inline", systemImage: "rectangle.and.pencil.and.ellipsis") }
            💁WidgetGuideTab()
                .tag(🔖Tab.guide)
                .tabItem { Label("Guide", systemImage: "questionmark") }
            🛠MenuTab()
                .tag(🔖Tab.menu)
                .tabItem { Label("Menu", systemImage: "gearshape") }
        }
        .onOpenURL { self.tab.handleURL($0) }
    }
}
