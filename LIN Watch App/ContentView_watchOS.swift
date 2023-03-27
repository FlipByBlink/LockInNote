import SwiftUI

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    @State private var 🔖tab: 🔖Tab = .rectangularWidget
    var body: some View {
        NavigationStack {
            TabView(selection: self.$🔖tab) {
                🅆idgetTab(ⓣext: self.$📱.widgetsModel.rectangular.text)
                    .tag(🔖Tab.rectangularWidget)
                    .navigationTitle("Rectangular")
                🅆idgetTab(ⓣext: self.$📱.widgetsModel.circular.text)
                    .tag(🔖Tab.circularWidget)
                    .navigationTitle("Circular")
                🅆idgetTab(ⓣext: self.$📱.widgetsModel.inline.text)
                    .tag(🔖Tab.inlineWidget)
                    .navigationTitle("Inline")
            }
        }
        .onOpenURL { ⓤrl in
            switch ⓤrl.description {
                case "Rectangular": self.🔖tab = .rectangularWidget
                case "Circular": self.🔖tab = .circularWidget
                case "Inline": self.🔖tab = .inlineWidget
                default: print("🐛")
            }
        }
    }
}

enum 🔖Tab {
    case rectangularWidget, circularWidget, inlineWidget
}

struct 🅆idgetTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    @Binding var ⓣext: String
    @State private var ⓢhowFullText: Bool = false
    var body: some View {
        VStack {
            Spacer()
            TextField("Input text", text: self.$ⓣext)
                .font(.title3)
                .onSubmit { self.📱.sendContextWithNewText() }
            Spacer()
            HStack {
                Button(role: .destructive) {
                    self.ⓣext = ""
                    self.📱.sendContextWithNewText()
                    WKInterfaceDevice.current().play(.success)
                } label: {
                    Image(systemName: "trash")
                        .fontWeight(.medium)
                }
                .disabled(self.ⓣext.isEmpty)
                Button {
                    self.ⓢhowFullText = true
                    WKInterfaceDevice.current().play(.directionUp)
                } label: {
                    Image(systemName: "doc.text.magnifyingglass")
                        .fontWeight(.medium)
                        .foregroundStyle(self.ⓣext.isEmpty ? .secondary : .primary)
                }
                .disabled(self.ⓣext.isEmpty)
                .sheet(isPresented: self.$ⓢhowFullText) {
                    ScrollView {
                        Text(self.ⓣext)
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
