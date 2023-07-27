import SwiftUI

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    @State private var tab: 🔖Tab = .rectangularWidget
    var body: some View {
        NavigationStack {
            TabView(selection: self.$tab) {
                🅆idgetTab(text: self.$📱.widgetsModel.rectangular.text)
                    .tag(🔖Tab.rectangularWidget)
                🅆idgetTab(text: self.$📱.widgetsModel.circular.text)
                    .tag(🔖Tab.circularWidget)
                🅆idgetTab(text: self.$📱.widgetsModel.inline.text)
                    .tag(🔖Tab.inlineWidget)
            }
            .navigationTitle(self.tab.navigationTitle)
        }
        .onOpenURL { ⓤrl in
            Task { @MainActor in
                //Adjust the tab movement bug
                try? await Task.sleep(for: .seconds(0.1))
                withAnimation(.default.speed(2)) {
                    self.tab.handleURL(ⓤrl)
                }
            }
        }
    }
}

struct 🅆idgetTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    @Binding var text: String
    @State private var showFullText: Bool = false
    var body: some View {
        VStack {
            Spacer()
            TextField("Input text", text: self.$text)
                .font(.title3)
                .onSubmit { self.📱.widgetsModel.sendWCMessageWithNewText() }
                .disabled(!📱.reachable)
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
                .disabled(!📱.reachable)
                Button {
                    self.showFullText = true
                    WKInterfaceDevice.current().play(.directionUp)
                } label: {
                    Image(systemName: "doc.text.magnifyingglass")
                        .fontWeight(.medium)
                        .foregroundStyle(self.text.isEmpty ? .secondary : .primary)
                }
                .disabled(self.text.isEmpty)
                .sheet(isPresented: self.$showFullText) {
                    ScrollView {
                        Text(self.text)
                            .font(.title2)
                            .multilineTextAlignment(.center)
                            .padding(.vertical, 24)
                    }
                    .toolbar(.hidden, for: .automatic)
                    .onTapGesture {
                        self.showFullText = false
                        WKInterfaceDevice.current().play(.directionDown)
                    }
                }
            }
        }
    }
}
