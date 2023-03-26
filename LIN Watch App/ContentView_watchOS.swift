import SwiftUI

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    @State private var 🔖tab: 🔖Tab = .rectangularWidget
    var body: some View {
        NavigationStack {
            TabView {
                TextField("Input text", text: self.$📱.widgetsModel.rectangular.text)
                    .navigationTitle("Rectangular")
                    .tag(🔖Tab.rectangularWidget)
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
