import SwiftUI
import WidgetKit

struct 💁WidgetGuideTab: View {
    var body: some View {
        NavigationStack {
            List {
                Self.StepByStepSection()
                Self.AppleSupportLinkSection()
                Self.AppleWatchSection()
            }
            .navigationTitle("How to add widgets")
        }
    }
}

private extension 💁WidgetGuideTab {
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
                        Image("WidgetGuide/\(ⓘndex)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120)
                            .padding(.vertical, 4)
                    }
                }
            } header: {
                Text("Lock Screen Widgets")
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
                Text("Apple Support Page Link")//, systemImage: "arrow.up.forward.app")
            }
            .headerProminence(.increased)
        }
    }
    
    private struct AppleWatchSection: View {
        var body: some View {
            Section {
                NavigationLink {
                    List {
                        Section {
                            HStack {
                                Text("Mirror the lock screen widget to the Apple Watch complication.")
                                Image(.watchExample)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120)
                            }
                            .padding(.vertical, 24)
                        }
                        Section {
                            Label("The changes may not be immediately reflected in the Apple Watch complication. At the latest, the changes will be applied in about 10 minutes.",
                                  systemImage: "exclamationmark.applewatch")
                            .padding(.vertical, 8)
                        }
                    }
                    .navigationTitle("Apple Watch app")
                } label: {
                    Label("About Apple Watch app", systemImage: "applewatch")
                }
            }
        }
    }
}
