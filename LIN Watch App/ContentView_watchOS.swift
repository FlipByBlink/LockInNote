import SwiftUI
import WatchConnectivity

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    @State private var 🔖tab: 🔖Tab = .rectangularWidget
    var body: some View {
        NavigationStack {
            TabView(selection: self.$🔖tab) {
                🅆idgetTab(text: self.$📱.widgetsModel.rectangular.text)
                    .tag(🔖Tab.rectangularWidget)
                🅆idgetTab(text: self.$📱.widgetsModel.circular.text)
                    .tag(🔖Tab.circularWidget)
                🅆idgetTab(text: self.$📱.widgetsModel.inline.text)
                    .tag(🔖Tab.inlineWidget)
            }
            .navigationTitle(self.🔖tab.navigationTitle)
        }
        .onOpenURL { self.🔖tab.handleURL($0) }
    }
}

enum 🔖Tab {
    case rectangularWidget, circularWidget, inlineWidget
    var navigationTitle: LocalizedStringKey {
        switch self {
            case .rectangularWidget: return "Rectangular"
            case .circularWidget: return "Circular"
            case .inlineWidget: return "Inline"
        }
    }
    mutating func handleURL(_ ⓤrl: URL) {
        switch ⓤrl.description {
            case "example:Rectangular": self = .rectangularWidget
            case "example:Circular": self = .circularWidget
            case "example:Inline": self = .inlineWidget
            default: print(ⓤrl); assertionFailure()
        }
    }
}

struct 🅆idgetTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    @Binding var text: String
    @State private var ⓢhowFullText: Bool = false
    var body: some View {
        VStack {
            Spacer()
            TextField("Input text", text: self.$text)
                .font(.title3)
                .onSubmit { self.📱.sendContextWithNewText() }
                .disabled(!📱.ⓡeachable)
            Spacer()
            HStack {
                Button(role: .destructive) {
                    self.text = ""
                    self.📱.sendContextWithNewText()
                    WKInterfaceDevice.current().play(.success)
                } label: {
                    Image(systemName: "trash")
                        .fontWeight(.medium)
                }
                .disabled(self.text.isEmpty)
                .disabled(!📱.ⓡeachable)
                Button {
                    self.ⓢhowFullText = true
                    WKInterfaceDevice.current().play(.directionUp)
                } label: {
                    Image(systemName: "doc.text.magnifyingglass")
                        .fontWeight(.medium)
                        .foregroundStyle(self.text.isEmpty ? .secondary : .primary)
                }
                .disabled(self.text.isEmpty)
                .sheet(isPresented: self.$ⓢhowFullText) {
                    ScrollView {
                        Text(self.text)
                            .font(.title2)
                            .multilineTextAlignment(.center)
                            .padding(.vertical, 24)
                    }
                    .toolbar(.hidden, for: .automatic)
                    .onTapGesture {
                        self.ⓢhowFullText = false
                        WKInterfaceDevice.current().play(.directionDown)
                    }
                }
            }
        }
    }
}
