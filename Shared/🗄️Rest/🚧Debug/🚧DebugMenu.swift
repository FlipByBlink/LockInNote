import SwiftUI

struct 🚧DebugMenu: View {
    @State private var iCloudKVSDictionary: [String: Any] = NSUbiquitousKeyValueStore.default.dictionaryRepresentation
    var body: some View {
        Section {
            NavigationLink {
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
            } label: {
                Text(verbatim: "NSUbiquitousKeyValueStore.default.dictionaryRepresentation")
            }
            Button {
                #if DEBUG
                💾ICloud.eraseAll()
                #endif
            } label: {
                Text(verbatim: "Erase all iCloudKVS")
            }
        } header: {
            Text(verbatim: "Debug")
        }
    }
}
