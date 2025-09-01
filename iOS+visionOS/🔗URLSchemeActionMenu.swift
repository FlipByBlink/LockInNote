import SwiftUI

struct 🔗URLSchemeActionMenuLink: View {
    var body: some View {
#if os(iOS)
        Section {
            NavigationLink {
                🔗URLSchemeActionMenu()
            } label: {
                Label("Setting URL scheme action", systemImage: "command")
            }
            HStack {
                Spacer()
                VStack {
                    Text(verbatim: "shortcuts://run-shortcut?nam...")
                        .rotationEffect(.degrees(-1.5))
                    Text(verbatim: "https://duckduckgo.com/?q=...")
                        .rotationEffect(.degrees(-1.5))
                    Text("etc.")
                        .rotationEffect(.degrees(-1.5))
                }
                Spacer()
            }
            .font(.subheadline.weight(.heavy).italic())
            .lineLimit(1)
            .foregroundStyle(.secondary)
            .scaleEffect(y: 1.33)
            .padding(.vertical, 32)
        } header: {
            Text("Custom action")
        }
#elseif os(visionOS)
        EmptyView()
#endif
    }
}

private struct 🔗URLSchemeActionMenu: View {
    @StateObject private var model: 🔗URLSchemeActionModel = .init()
    var body: some View {
        List {
            Section {
                🔗URLSchemeActionMenuComponent.InputView()
                    .textFieldStyle(.roundedBorder)
                    .listRowSeparator(.hidden)
            } header: {
                Text("URL scheme")
            }
            Section {
                🔗URLSchemeActionMenuComponent.TestButton()
            } header: {
                Text("Test")
            } footer: {
                🔗URLSchemeActionMenuComponent.TestButtonFooter()
            }
            Section {
                🔗URLSchemeActionMenuComponent.ButtonLabelSection(addPrompt: true)
                    .textFieldStyle(.roundedBorder)
            } header: {
                Text("Button label")
            }
            🔗URLSchemeActionMenuComponent.EraseTextAfterActionSection()
            Section {
                🔗URLSchemeActionMenuComponent.Example1.Preview()
                    .font(.subheadline)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
            } header: {
                Text(🔗URLSchemeActionMenuComponent.Example1.header)
            } footer: {
                🔗URLSchemeActionMenuComponent.Example1.Footer()
            }
            Section {
                🔗URLSchemeActionMenuComponent.Example2.Preview()
                    .font(.subheadline)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
            } header: {
                Text(🔗URLSchemeActionMenuComponent.Example2.header)
            } footer: {
                🔗URLSchemeActionMenuComponent.Example2.Footer()
            }
            🔗URLSchemeActionMenuComponent.SampleImage()
                .frame(maxHeight: 300)
                .listRowBackground(Color.clear)
            Section {
                🔗URLSchemeActionMenuComponent.NoticeSection()
            } header: {
                Text("Notice")
            }
        }
        .navigationTitle("Customize Action")
        .environmentObject(self.model)
    }
}
