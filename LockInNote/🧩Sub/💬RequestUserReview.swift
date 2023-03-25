import SwiftUI

//リクエスト発生させるViewで以下を実装
//@State private var checkToRequestReview: Bool = false
//.modifier(💬PrepareToRequestUserReview(self.$checkToRequestReview))
//self.checkToRequestReview = true
struct 💬RequestUserReview: ViewModifier {//アプリ毎に個別に実装する
    @State private var ⓒheckToRequest: Bool = false
    func body(content: Content) -> some View {
        content
            .modifier(💬PrepareToRequestUserReview(self.$ⓒheckToRequest))
            .onAppear { self.ⓒheckToRequest = true }
    }
}
