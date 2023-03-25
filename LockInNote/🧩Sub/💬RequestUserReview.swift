import SwiftUI

struct 💬RequestUserReview: ViewModifier {
    @State private var ⓒheckToRequest: Bool = false
    @Binding private var 🔖tab: 🔖Tab
    func body(content: Content) -> some View {
        content
            .modifier(💬PrepareToRequestUserReview(self.$ⓒheckToRequest))
            .onChange(of: self.🔖tab) {
                if $0 == .menu {
                    self.ⓒheckToRequest = true
                }
            }
    }
    init(_ tab: Binding<🔖Tab>) {
        self._🔖tab = tab
    }
}
