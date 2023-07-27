import SwiftUI

struct 💬RequestUserReview: ViewModifier {
    @State private var checkToRequest: Bool = false
    @Binding private var tab: 🔖Tab
    func body(content: Content) -> some View {
        content
            .modifier(💬PrepareToRequestUserReview(self.$checkToRequest))
            .onChange(of: self.tab) {
                if $0 == .menu {
                    self.checkToRequest = true
                }
            }
    }
    init(_ tab: Binding<🔖Tab>) {
        self._tab = tab
    }
}
