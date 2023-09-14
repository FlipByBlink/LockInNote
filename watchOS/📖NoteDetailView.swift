import SwiftUI

struct 📖NoteDetailView: View {
    @EnvironmentObject var app: 📱AppModel
    var body: some View {
        if case .note(let ⓕamily) = self.app.tab {
            ScrollView {
                Text(self.app.note(ⓕamily).text)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 24)
            }
        } else {
            EmptyView()
        }
    }
}
