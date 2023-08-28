import SwiftUI

struct 🔗URLSchemeActionMenuLink: View {
    @Environment(\.openWindow) var openWindow
    var body: some View {
        Button("Customize action") {
            self.openWindow(id: "customizeAction")
        }
    }
}

struct 🔗URLSchemeActionMenuWindow: Scene {
    @StateObject private var model: 🔗URLSchemeActionModel = .init()
    var body: some Scene {
        Window("Customize action", id: "customizeAction") {
            Form {
                🔗URLSchemeActionMenuComponent.InputView()
                Divider()
                LabeledContent {
                    HStack {
                        🔗URLSchemeActionMenuComponent.TestButton()
                        🔗URLSchemeActionMenuComponent.TestButtonFooter()
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                } label: {
                    Text("Test")
                        .foregroundStyle(.secondary)
                }
                Divider()
                🔗URLSchemeActionMenuComponent.ButtonLabelSection()
                Divider()
                🔗URLSchemeActionMenuComponent.EraseTextAfterActionSection()
                Divider()
                GroupBox(🔗URLSchemeActionMenuComponent.Example1.header) {
                    VStack(spacing: 8) {
                        🔗URLSchemeActionMenuComponent.Example1.Preview()
                        🔗URLSchemeActionMenuComponent.Example1.Footer()
                            .font(.caption)
                    }
                    .padding(8)
                    .frame(maxWidth: .infinity)
                }
                Divider()
                GroupBox(🔗URLSchemeActionMenuComponent.Example2.header) {
                    VStack(spacing: 8) {
                        🔗URLSchemeActionMenuComponent.Example2.Preview()
                        🔗URLSchemeActionMenuComponent.Example2.Footer()
                            .font(.caption)
                    }
                    .padding(8)
                    .frame(maxWidth: .infinity)
                }
                Divider()
                🔗URLSchemeActionMenuComponent.NoticeSection()
                    .foregroundStyle(.secondary)
            }
            .padding()
            .frame(minWidth: 800, minHeight: 600)
            .environmentObject(self.model)
        }
    }
}
