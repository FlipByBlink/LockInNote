import SwiftUI

struct 💁HowToGuideSection: View {
    var body: some View {
        Section {
            NavigationLink {
                💁HowToHomeScreen()
            } label: {
                Label("How to add home screen widget", systemImage: "questionmark")
            }
            NavigationLink {
                💁HowToLockScreen()
            } label: {
                Label("How to add lock screen widget", systemImage: "questionmark")
            }
            💁ICloudSyncSection()
        } header: {
            Text("Guide")
        }
    }
}

struct 💁HowToHomeScreen: View {
    var body: some View {
        List {
            Self.StepByStepSection()
            Self.AppleSupportLinkSection()
        }
        .navigationTitle("Lock screen widget")
    }
    private struct StepByStepSection: View {
        private let steps: [Int: LocalizedStringKey] = [
            1: "Touch and hold the home screen until the + button appears, then tap + button.",
            2: #"Select "LockInNote"."#,
            3: "Tap or drag the widgets that you want to add to the Lock Screen.",
            4: "When you're finished, tap the Done button."
        ]
        var body: some View {
            Section {
                ForEach(1 ... 4, id: \.self) { ⓘndex in
                    HStack {
                        Label {
                            if let ⓣext = self.steps[ⓘndex] {
                                Text(ⓣext)
                            }
                        } icon: {
                            Text(verbatim: "\(ⓘndex).")
                                .font(.system(.title3, design: .rounded, weight: .semibold))
                        }
                        Spacer()
                        Image("WidgetGuide/HomeScreen/\(ⓘndex)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120)
                            .padding(.vertical, 4)
                    }
                }
            }
        }
    }
    private struct AppleSupportLinkSection: View {
        var body: some View {
            Section {
                VStack(alignment: .leading, spacing: 6) {
                    Link(destination: URL(string: "https://support.apple.com/HT207122")!) {
                        Label("How to add and edit widgets on your iPhone", systemImage: "link")
                    }
                    HStack {
                        Spacer()
                        Text(verbatim: "https://support.apple.com/HT207122")
                            .font(.caption2.italic())
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                }
                .padding(.vertical, 4)
            } header: {
                Text("Apple Support Page Link")
            }
            .headerProminence(.increased)
        }
    }
}

struct 💁HowToLockScreen: View {
    var body: some View {
        List {
            Self.StepByStepSection()
            Self.AppleSupportLinkSection()
        }
        .navigationTitle("Lock screen widget")
    }
    private struct StepByStepSection: View {
        private let steps: [Int: LocalizedStringKey] = [
            1: "Touch and hold the Lock Screen until the Customize button appears, then tap Customize.",
            2: "Select Lock Screen.",
            3: "Tap Add Widgets.",
            4: "Tap or drag the widgets that you want to add to the Lock Screen.",
            5: "When you're finished, tap the close button, then tap Done."
        ]
        var body: some View {
            Section {
                ForEach(1 ... 5, id: \.self) { ⓘndex in
                    HStack {
                        Label {
                            if let ⓣext = self.steps[ⓘndex] {
                                Text(ⓣext)
                            }
                        } icon: {
                            Text(verbatim: "\(ⓘndex).")
                                .font(.system(.title3, design: .rounded, weight: .semibold))
                        }
                        Spacer()
                        Image("WidgetGuide/LockScreen/\(ⓘndex)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120)
                            .padding(.vertical, 4)
                    }
                }
            }
        }
    }
    private struct AppleSupportLinkSection: View {
        var body: some View {
            Section {
                VStack(alignment: .leading, spacing: 6) {
                    Link(destination: URL(string: "https://support.apple.com/HT207122")!) {
                        Label("How to add and edit widgets on your iPhone", systemImage: "link")
                    }
                    HStack {
                        Spacer()
                        Text(verbatim: "https://support.apple.com/HT207122")
                            .font(.caption2.italic())
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                }
                .padding(.vertical, 4)
                VStack(alignment: .leading, spacing: 6) {
                    Link(destination: URL(string: "https://support.apple.com/guide/iphone/create-a-custom-lock-screen-iph4d0e6c351/ios")!) {
                        Label("Create a custom iPhone Lock Screen", systemImage: "link")
                    }
                    HStack {
                        Spacer()
                        Text(verbatim: "https://support.apple.com/guide/iphone/create-a-custom-lock-screen-iph4d0e6c351/ios")
                            .font(.caption2.italic())
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                }
                .padding(.vertical, 4)
            } header: {
                Text("Apple Support Page Link")
            }
            .headerProminence(.increased)
        }
    }
}

private struct 💁ICloudSyncSection: View {
    var body: some View {
        NavigationLink {
            List {
                Section {
                    Label("Sync data between devices by iCloud.", systemImage: "icloud")
                        .listRowSeparator(.hidden)
                    Image(.concept)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(8)
                } footer: {
                    Text("It takes few minutes to sync data to other device's widget on background.")
                }
            }
            .navigationTitle("iCloud sync")
        } label: {
            Label("iCloud sync", systemImage: "icloud")
        }
    }
}
