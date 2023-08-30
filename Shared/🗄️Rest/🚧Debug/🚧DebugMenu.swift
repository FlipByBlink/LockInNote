import SwiftUI

struct 🚧DebugMenu: View {
    @State var iCloudKVSDictionary: [String: Any] = NSUbiquitousKeyValueStore.default.dictionaryRepresentation
    var body: some View {
#if DEBUG
        Section {
            NavigationLink("NSUbiquitousKeyValueStore.default.dictionaryRepresentation" as String) {
                List {
                    ForEach(self.iCloudKVSDictionary.keys.sorted(), id: \.self) { ⓚey in
                        LabeledContent {
                            if let ⓓata = self.iCloudKVSDictionary[ⓚey] as? Data {
                                Text(String(data: ⓓata, encoding: .utf8) ?? "🐛")
                            } else {
                                Text(String(describing: self.iCloudKVSDictionary[ⓚey]!))
                            }
                        } label: {
                            Text(ⓚey)
                        }
                    }
                }
                .refreshable {
                    self.iCloudKVSDictionary = NSUbiquitousKeyValueStore.default.dictionaryRepresentation
                }
            }
            Button("Erase all iCloudKVS" as String) { 💾ICloud.eraseAll() }
        } header: {
            Text(verbatim: "Debug")
        }
#else
        EmptyView()
#endif
    }
}
