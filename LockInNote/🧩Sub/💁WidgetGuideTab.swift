import SwiftUI
import WidgetKit

struct 💁WidgetGuideTab: View {
    var body: some View {
        NavigationStack {
            GeometryReader { 📐 in
                List {
                    💁StepByStepSection()
                    self.ⓢupportPageLinkSection()
                }
            }
            .navigationTitle("How to add widgets")
        }
    }
    private func ⓢupportPageLinkSection() -> some View {
        Section {
            Link(destination: URL(string: "https://support.apple.com/HT207122")!) {
                Label("How to add and edit widgets on your iPhone", systemImage: "link")
            }
            Link(destination: URL(string: "https://support.apple.com/guide/iphone/create-a-custom-lock-screen-iph4d0e6c351/ios")!) {
                Label("Create a custom iPhone Lock Screen", systemImage: "link")
            }
        } header: {
            Label("support.apple.com", systemImage: "arrow.up.forward.app")
        }
    }
}

private struct 💁StepByStepSection: View {
    private let ⓢteps: [LocalizedStringKey] = [
        "Touch and hold the Lock Screen until the Customize button appears, then tap Customize.",
        "Select Lock Screen.",
        "Tap Add Widgets.",
        "Tap or drag the widgets that you want to add to the Lock Screen.",
        "When you're finished, tap the close button, then tap Done."
    ]
    var body: some View {
        Section {
            ForEach(1 ... 5, id: \.self) { ⓘndex in
                HStack {
                    Label {
                        Text(self.ⓢteps[ⓘndex - 1])
                    } icon: {
                        Text("\(ⓘndex).")
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
