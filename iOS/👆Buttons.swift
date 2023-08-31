import SwiftUI

struct 👆EditButton: View { // 🖊️
    var focusAction: () -> Void
    var body: some View {
        Button {
            self.focusAction()
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        } label: {
            Image(systemName: "pencil")
                .foregroundStyle(.white)
                .font(.largeTitle.weight(.black))
                .padding()
        }
        .background(Circle().fill(.tint))
        .shadow(radius: 3)
        .padding()
    }
}

struct 👆DoneButton: View { // ☑️
    @EnvironmentObject var app: 📱AppModel
    @EnvironmentObject var iap: 🛒InAppPurchaseModel
    var unfocusAction: () -> Void
    var body: some View {
        Button {
            self.unfocusAction()
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            if self.iap.checkToShowADSheet() { self.app.sheet = .ad }
        } label: {
            Label("Done", systemImage: "checkmark")
                .labelStyle(.iconOnly)
                .foregroundStyle(.white)
                .font(.largeTitle.weight(.bold))
                .padding()
        }
        .background(Circle().fill(.tint))
        .shadow(radius: 3)
    }
}

struct 👆EraseButtonAndShareButton: View { // 🗑 📤
    @EnvironmentObject var note: 📝NoteModel
    @Environment(\.colorScheme) var colorScheme
    private var disable: Bool { self.note.text.isEmpty }
    private var iconColor: Color {
        if self.disable {
            switch self.colorScheme {
                case .light: Color(white: 0.9)
                case .dark: Color(white: 0.6)
                @unknown default: Color(white: 0.9)
            }
        } else {
            .white
        }
    }
    private func backgroundColor(_ ⓒolor: Color) -> Color {
        if self.disable {
            switch self.colorScheme {
                case .light: Color(white: 0.6)
                case .dark: Color(white: 0.3)
                @unknown default: Color(white: 0.6)
            }
        } else {
            ⓒolor
        }
    }
    var body: some View {
        HStack(spacing: 12) {
            Button {
                withAnimation { self.note.text.removeAll() }
                UINotificationFeedbackGenerator().notificationOccurred(.error)
            } label: {
                Label("Erase", systemImage: "trash")
                    .foregroundStyle(self.iconColor)
                    .labelStyle(.iconOnly)
                    .font(.largeTitle.weight(.semibold))
                    .padding()
                    .shadow(radius: self.disable ? 0 : 3)
            }
            .disabled(self.disable)
            .background {
                Circle()
                    .foregroundStyle(self.backgroundColor(.red))
                    .shadow(radius: 3)
            }
            .animation(.default, value: self.disable)
            ShareLink(item: self.note.text)
                .labelStyle(.iconOnly)
                .disabled(self.disable)
                .shadow(radius: self.disable ? 0 : 3)
                .foregroundStyle(self.iconColor)
                .font(.largeTitle.weight(.semibold))
                .padding()
                .background {
                    Circle()
                        .foregroundStyle(self.backgroundColor(.teal))
                        .shadow(radius: 3)
                }
        }
    }
}
