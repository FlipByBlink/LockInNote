import SwiftUI

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    @State private var 🔖tab: 🔖Tab = .rectangularWidget
    @State private var ⓢhowFullText: Bool = false
    var body: some View {
        NavigationStack {
            TabView {
                VStack {
                    Spacer()
                    TextField("Input text", text: self.$📱.widgetsModel.rectangular.text)
                        .font(.title3)
                    Spacer()
                    HStack {
                        Button(role: .destructive) {
                            self.📱.widgetsModel.rectangular.text = ""
                        } label: {
                            Image(systemName: "trash")
                        }
                        Button {
                            self.ⓢhowFullText = true
                        } label: {
                            Image(systemName: "doc.text.magnifyingglass")
                                .fontWeight(.medium)
                                .padding(4)
                        }
                        .disabled(self.📱.widgetsModel.rectangular.text.isEmpty)
                        .sheet(isPresented: self.$ⓢhowFullText) {
                            ScrollView {
                                Text(self.📱.widgetsModel.rectangular.text)
                                    .font(.title2)
                                    .padding()
                            }
                        }
                    }
                }
                .tag(🔖Tab.rectangularWidget)
                .navigationTitle("Rectangular")
                TextField("Input text", text: self.$📱.widgetsModel.circular.text)
                    .navigationTitle("Circular")
                    .tag(🔖Tab.circularWidget)
                TextField("Input text", text: self.$📱.widgetsModel.inline.text)
                    .navigationTitle("Inline")
                    .tag(🔖Tab.inlineWidget)
            }
            .onSubmit { self.📱.saveAndReloadWidgetAndUpdateWCContext() }
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
