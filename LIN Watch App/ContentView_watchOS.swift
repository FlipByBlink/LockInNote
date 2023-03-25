import SwiftUI

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    @AppStorage("TEXT", store: UserDefaults(suiteName: "group.net.aaaakkkkssssttttnnnn.AppTemplate"))
    private var ⓣext = "placeholder"
    var body: some View {
        NavigationStack {
            TextField("Input text", text: self.$ⓣext)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
