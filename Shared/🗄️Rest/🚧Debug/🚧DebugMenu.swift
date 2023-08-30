import SwiftUI

struct 🚧DebugMenu: ViewModifier {
    @State private var show: Bool = false
    @State private var iCloudKVSDictionary: [String: Any] = NSUbiquitousKeyValueStore.default.dictionaryRepresentation
    func body(content: Content) -> some View {
#if DEBUG
        content
            .refreshable { self.show.toggle() }
            .sheet(isPresented: self.$show) { self.menu() }
#else
        content
#endif
    }
    private func menu() -> some View {
        NavigationStack {
            List {
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
                    NSUbiquitousKeyValueStore.default.dictionaryRepresentation.keys.forEach {
                        NSUbiquitousKeyValueStore.default.removeObject(forKey: $0)
                    }
                } label: {
                    Text(verbatim: "Erase all iCloudKVS")
                }
            }
            .navigationTitle(Text(verbatim: "Debug"))
        }
    }
}
