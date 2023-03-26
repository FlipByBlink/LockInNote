import SwiftUI

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        NavigationStack {
            TabView {
                TextField("Input text", text: self.$📱.widgetsModel.rectangular.text)
                    .navigationTitle("Rectangular")
                TextField("Input text", text: self.$📱.widgetsModel.circular.text)
                    .navigationTitle("Circular")
                TextField("Input text", text: self.$📱.widgetsModel.inline.text)
                    .navigationTitle("Inline")
            }
            .onSubmit { self.📱.saveAndReloadWidgetAndUpdateWCContext() }
        }
    }
}
