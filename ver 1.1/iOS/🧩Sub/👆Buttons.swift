import SwiftUI

struct 👆EditButton: View { // 🖊️
    private var focusAction: () -> Void
    var body: some View {
        Button {
            self.focusAction()
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        } label: {
            Image(systemName: "pencil")
                .foregroundColor(.white)
                .font(.largeTitle.weight(.black))
                .padding()
        }
        .background {
            Circle()
                .foregroundColor(.accentColor)
        }
        .shadow(radius: 3)
        .padding()
    }
    init(_ focusAction: @escaping () -> Void) {
        self.focusAction = focusAction
    }
}

struct 👆DoneButton: View { // ☑️
    @EnvironmentObject var 📱: 📱AppModel
    //@EnvironmentObject var 🛒: 🛒InAppPurchaseModel
    private var unfocusAction: () -> Void
    var body: some View {
        Button {
            self.unfocusAction()
            📱.widgetsModel.saveData_reloadWidget_updateWCContext()
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            Task { @MainActor in
                try await Task.sleep(for: .seconds(0.45))
                //if 🛒.checkToShowADSheet() { self.showAD = true }
            }
        } label: {
            Label("Done", systemImage: "checkmark")
                .labelStyle(.iconOnly)
                .foregroundColor(.white)
                .font(.largeTitle.weight(.bold))
                .padding()
        }
        .background(Circle().foregroundColor(.accentColor))
        .shadow(radius: 3)
    }
    init(_ unfocusAction: @escaping () -> Void) {
        self.unfocusAction = unfocusAction
    }
}

struct 👆EraseButtonAndShareButton: View { // 🗑 📤
    @Binding private var text: String
    private var disable: Bool { self.text.isEmpty }
    @Environment(\.colorScheme) var colorScheme
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
                withAnimation {
                    self.text = ""
                    UINotificationFeedbackGenerator().notificationOccurred(.warning)
                }
            } label: {
                Label("Erase", systemImage: "trash")
                    .foregroundColor(self.iconColor)
                    .labelStyle(.iconOnly)
                    .font(.largeTitle.weight(.semibold))
                    .padding()
                    .shadow(radius: self.disable ? 0 : 3)
            }
            .disabled(self.disable)
            .background {
                Circle()
                    .foregroundColor(self.backgroundColor(.red))
                    .shadow(radius: 3)
            }
            .animation(.default, value: self.disable)
            ShareLink(item: self.text)
                .labelStyle(.iconOnly)
                .disabled(self.disable)
                .shadow(radius: self.disable ? 0 : 3)
                .foregroundColor(self.iconColor)
                .font(.largeTitle.weight(.semibold))
                .padding()
                .background {
                    Circle()
                        .foregroundColor(self.backgroundColor(.teal))
                        .shadow(radius: 3)
                }
        }
    }
    init(_ text: Binding<String>) {
        self._text = text
    }
}

struct 👆AdjustButtonsBackground: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        content
            .background {
                if self.colorScheme == .light {
                    Color(.secondarySystemBackground)
                }
            }
    }
}
