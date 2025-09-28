import SwiftUI

struct ℹ️HelpWindows: Scene {
    var body: some Scene {
        Group {
            📰DescriptionWindow()
            👤PrivacyPolicyWindow()
            📜VersionHistoryWindow()
            📓SourceCodeWindow()
            🧑‍💻DeveloperPublisherWindow()
        }
        .commandsRemoved()
    }
}

private struct 📰DescriptionWindow: Scene {
    var body: some Scene {
        Window(.init("Description", tableName: "🌐AboutApp"), id: "Description") {
            ScrollView {
                Text("current", tableName: "🌐AppStoreDescription")
                    .padding(32)
                    .frame(maxWidth: .infinity)
            }
            .textSelection(.enabled)
            .frame(width: 600, height: 500)
        }
        .windowResizability(.contentSize)
    }
}

private struct 👤PrivacyPolicyWindow: Scene {
    var body: some Scene {
        Window(.init("Privacy Policy", tableName: "🌐AboutApp"), id: "PrivacyPolicy") {
            Text(🗒️StaticInfo.privacyPolicyDescription)
                .font(.title3)
                .padding(32)
                .textSelection(.enabled)
                .frame(width: 500, height: 400)
        }
        .windowResizability(.contentSize)
    }
}

private struct 📜VersionHistoryWindow: Scene {
    var body: some Scene {
        Window(.init("Version History", tableName: "🌐AboutApp"), id: "VersionHistory") {
            List {
                ForEach(🗒️StaticInfo.versionInfos, id: \.version) { ⓘnfo in
                    GroupBox(ⓘnfo.version) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(LocalizedStringKey(ⓘnfo.version), tableName: "🌐VersionHistory")
                                .font(.subheadline)
                                .textSelection(.enabled)
                            Group {
                                if 🗒️StaticInfo.versionInfos.first?.version == ⓘnfo.version {
                                    Text("builded on \(ⓘnfo.date)", tableName: "🌐AboutApp")
                                } else {
                                    Text("released on \(ⓘnfo.date)", tableName: "🌐AboutApp")
                                }
                            }
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        }
                        .padding()
                    }
                    .padding(.vertical, 4)
                    .listRowSeparator(.hidden)
                }
            }
            .frame(width: 350, height: 450)
        }
        .windowResizability(.contentSize)
    }
}

private struct 📓SourceCodeWindow: Scene {
    var body: some Scene {
        Window(.init("Source code", tableName: "🌐AboutApp"), id: "SourceCode") {
            NavigationSplitView {
                List {
                    ForEach(🗒️StaticInfo.SourceCodeCategory.allCases) { Self.CodeSection($0) }
                    Divider()
                    self.repositoryLinks()
                }
                .navigationTitle(.init("Source code", tableName: "🌐AboutApp"))
                .frame(minWidth: 270)
            } detail: {
                Text("← Select file", tableName: "🌐AboutApp")
                    .foregroundStyle(.tertiary)
            }
            .frame(minWidth: 1100, minHeight: 600)
        }
        .windowResizability(.contentMinSize)
    }
    private struct CodeSection: View {
        private var category: 🗒️StaticInfo.SourceCodeCategory
        private var url: URL {
            Bundle.main.bundleURL.appendingPathComponent("Contents/Resources/📁SourceCode")
        }
        var body: some View {
            Section {
                ForEach(self.category.fileNames, id: \.self) { ⓕileName in
                    if let ⓒode = try? String(
                        contentsOf: self.url.appendingPathComponent(ⓕileName),
                        encoding: .utf8
                    ) {
                        NavigationLink(ⓕileName) { self.sourceCodeView(ⓒode, ⓕileName) }
                    } else {
                        Text(verbatim: "🐛")
                    }
                }
                if self.category.fileNames.isEmpty { Text(verbatim: "🐛") }
            } header: {
                Text(self.category.rawValue)
                    .textCase(.none)
            }
        }
        init(_ category: 🗒️StaticInfo.SourceCodeCategory) {
            self.category = category
        }
        private func sourceCodeView(_ ⓣext: String, _ ⓣitle: String) -> some View {
            ScrollView {
                ScrollView(.horizontal, showsIndicators: false) {
                    Text(ⓣext)
                        .monospaced()
                        .padding()
                }
            }
            .environment(\.layoutDirection, .leftToRight)
            .navigationTitle(LocalizedStringKey(ⓣitle))
            .textSelection(.enabled)
        }
    }
    private func repositoryLinks() -> some View {
        NavigationLink {
            VStack {
                Spacer()
                Text("Git repository is public on GitHub.com", tableName: "🌐AboutApp")
                    .font(.title2.weight(.medium))
                Spacer()
                VStack {
                    Link(destination: 🗒️StaticInfo.webRepositoryURL) {
                        HStack {
                            Text("Web Repository", tableName: "🌐AboutApp")
                                .font(.title3)
                            Image(systemName: "arrow.up.forward.app")
                                .foregroundStyle(.secondary)
                        }
                    }
                    Text(verbatim: "\(🗒️StaticInfo.webRepositoryURL)")
                        .foregroundStyle(.secondary)
                        .font(.subheadline.italic())
                }
                Spacer()
                VStack {
                    Link(destination: 🗒️StaticInfo.webMirrorRepositoryURL) {
                        HStack {
                            Text("(Mirror)", tableName: "🌐AboutApp")
                            Image(systemName: "arrow.up.forward.app")
                        }
                        .foregroundStyle(.secondary)
                    }
                    Text(verbatim: "\(🗒️StaticInfo.webMirrorRepositoryURL)")
                        .foregroundStyle(.secondary)
                        .font(.subheadline.italic())
                }
                Spacer()
            }
            .navigationTitle(.init("Web Repository", tableName: "🌐AboutApp"))
        } label: {
            Label(String(localized: "Web Repository", table: "🌐AboutApp"),
                  systemImage: "link")
        }
    }
}

private struct 🧑‍💻DeveloperPublisherWindow: Scene {
    var body: some Scene {
        Window(.init("Developer / Publisher", tableName: "🌐AboutApp"), id: "DeveloperPublisher") {
            List {
                Section {
                    GroupBox {
                        LabeledContent {
                            Text("only one person", tableName: "🌐AboutApp")
                        } label: {
                            Text("Individual", tableName: "🌐AboutApp")
                        }
                        .padding(4)
                    }
                    .listRowSeparator(.hidden)
                } header: {
                    Text("The System", tableName: "🌐AboutApp")
                }
                Section {
                    GroupBox {
                        LabeledContent("山下 亮" as String, value: "Yamashita Ryo")
                            .padding(4)
                            .modifier(Self.TypeSettingLanguage())
                    }
                    .listRowSeparator(.hidden)
                } header: {
                    Text("Name", tableName: "🌐AboutApp")
                }
                Section {
                    GroupBox {
                        VStack {
                            LabeledContent {
                                Text("about 29", tableName: "🌐AboutApp")
                            } label: {
                                Text("age", tableName: "🌐AboutApp")
                            }
                            LabeledContent {
                                Text("Japan", tableName: "🌐AboutApp")
                            } label: {
                                Text("country", tableName: "🌐AboutApp")
                            }
                            LabeledContent {
                                Text("Japanese", tableName: "🌐AboutApp")
                            } label: {
                                Text("native language", tableName: "🌐AboutApp")
                            }
                            Text("As of 2023", tableName: "🌐AboutApp")
                                .font(.caption)
                                .foregroundStyle(.tertiary)
                        }
                        .padding(4)
                    }
                    .listRowSeparator(.hidden)
                } header: {
                    Text("background", tableName: "🌐AboutApp")
                }
                Self.TimelineSection()
                Section {
                    VStack(spacing: 8) {
                        Image(.developerPublisher)
                            .resizable()
                            .frame(width: 90, height: 90)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .opacity(0.6)
                        Text("Taken on 2021-11", tableName: "🌐AboutApp")
                            .font(.caption)
                            .foregroundStyle(.tertiary)
                    }
                    .padding(12)
                } header: {
                    Text("Image", tableName: "🌐AboutApp")
                }
            }
            .frame(width: 540, height: 540)
        }
        .windowResizability(.contentSize)
    }
    private struct TypeSettingLanguage: ViewModifier {
        func body(content: Content) -> some View {
            if #available(macOS 14.0, *) {
                content.typesettingLanguage(.init(languageCode: .japanese))
            } else {
                content
            }
        }
    }
    private struct TimelineSection: View {
        private static var localizedStringResources: [LocalizedStringResource] {
            [
                .init("2013-04", table: "🌐Timeline"),
                .init("2018-06", table: "🌐Timeline"),
                .init("2019-01", table: "🌐Timeline"),
                .init("2019-03", table: "🌐Timeline"),
                .init("2019-05", table: "🌐Timeline"),
                .init("2019-07", table: "🌐Timeline"),
                .init("2021-12", table: "🌐Timeline"),
                .init("2022-02", table: "🌐Timeline"),
                .init("2022-04", table: "🌐Timeline"),
                .init("2022-05", table: "🌐Timeline"),
                .init("2022-06", table: "🌐Timeline"), //two lines
                .init("2022-09", table: "🌐Timeline"),
                .init("2023-02", table: "🌐Timeline"),
                .init("2023-04", table: "🌐Timeline"),
                .init("2023-05", table: "🌐Timeline"),
                .init("2024-02", table: "🌐Timeline"),
            ]
        }
        var body: some View {
            Section {
                GroupBox {
                    Grid {
                        ForEach(Self.localizedStringResources, id: \.self.key) { ⓡesource in
                            GridRow {
                                Text(ⓡesource.key)
                                    .font(.subheadline)
                                    .padding(8)
                                Text(ⓡesource)
                                    .font(.subheadline)
                                    .gridCellAnchor(.leading)
                            }
                        }
                    }
                }
                .listRowSeparator(.hidden)
            } header: {
                Text("Timeline", tableName: "🌐AboutApp")
            }
        }
    }
}
