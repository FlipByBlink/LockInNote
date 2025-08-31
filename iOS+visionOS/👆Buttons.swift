import SwiftUI

struct 👆EditButton: View { // 🖊️
    var focusAction: () -> Void
    var body: some View {
#if os(iOS)
        Button {
            self.focusAction()
            💥Feedback.light()
        } label: {
            Image(systemName: "pencil")
                .foregroundStyle(.white)
                .font(.largeTitle.weight(.black))
                .padding()
        }
        .background(Circle().fill(.tint))
        .shadow(radius: 3)
        .padding()
#elseif os(visionOS)
        Button {
            self.focusAction()
        } label: {
            Image(systemName: "pencil")
                .foregroundStyle(.white)
                .font(.largeTitle.weight(.black))
                .padding()
                .background(Circle().fill(.tint))
        }
        .buttonStyle(.plain)
        .shadow(radius: 3)
        .padding()
#endif
    }
}

struct 👆DoneButton: View { // ☑️
    @EnvironmentObject var app: 📱AppModel
    @EnvironmentObject var iap: 🛒InAppPurchaseModel
    @Environment(\.verticalSizeClass) var verticalSizeClass
    var unfocusAction: () -> Void
    var body: some View {
        Button {
            self.unfocusAction()
            💥Feedback.success()
            if self.iap.checkToShowADSheet() { self.app.sheet = .ad }
        } label: {
            Label("Done", systemImage: "checkmark")
                .labelStyle(.iconOnly)
                .foregroundStyle(.white)
                .font(self.verticalSizeClass == .compact ? .title3 : .largeTitle)
                .fontWeight(.semibold)
                .padding(self.verticalSizeClass == .compact ? 8 : 16)
        }
        .background(Circle().fill(.tint))
        .shadow(radius: 3)
    }
}

struct 👆EraseButtonAndShareButton: View { // 🗑 📤
    @EnvironmentObject var note: 📝NoteModel
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.verticalSizeClass) var verticalSizeClass
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
                💥Feedback.error()
            } label: {
                Label("Erase", systemImage: "trash")
                    .foregroundStyle(self.iconColor)
                    .labelStyle(.iconOnly)
                    .font(self.verticalSizeClass == .compact ? .title3 : .largeTitle)
                    .fontWeight(.semibold)
                    .padding(self.verticalSizeClass == .compact ? 8 : 16)
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
                .font(self.verticalSizeClass == .compact ? .title3 : .largeTitle)
                .fontWeight(.semibold)
                .padding(self.verticalSizeClass == .compact ? 8 : 16)
                .background {
                    Circle()
                        .foregroundStyle(self.backgroundColor(.teal))
                        .shadow(radius: 3)
                }
        }
    }
}
