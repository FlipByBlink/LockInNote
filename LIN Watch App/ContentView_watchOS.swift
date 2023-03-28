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
        .onOpenURL { ⓤrl in
            Task { @MainActor in
                //Adjust the tab movement
                try? await Task.sleep(for: .seconds(0.66))
                self.🔖tab.handleURL(ⓤrl)
            }
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
                .onSubmit { self.📱.widgetsModel.sendWCMessageWithNewText() }
                .disabled(!📱.ⓡeachable)
            Spacer()
            HStack {
                Button(role: .destructive) {
                    self.text = ""
                    self.📱.widgetsModel.sendWCMessageWithNewText()
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
