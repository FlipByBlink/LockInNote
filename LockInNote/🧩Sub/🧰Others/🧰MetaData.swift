import Foundation

let 📜versionInfos = 📜VersionInfo.history(("1.0.4","2023-01-30"),
                                           ("1.0.3","2022-12-09"),
                                           ("1.0.2","2022-11-08"),
                                           ("1.0.1","2022-09-15"),
                                           ("1.0", "2022-09-13")) //降順。先頭の方が新しい

let 🔗appStoreProductURL = URL(string: "https://apps.apple.com/app/id1644879340")!

let 👤privacyPolicy = """
2022-09-12

(English) This application don't collect user infomation.

(Japanese) このアプリ自身において、ユーザーの情報を一切収集しません。
"""

let 🔗webRepositoryURL = URL(string: "https://github.com/FlipByBlink/LockInNote")!
let 🔗webRepositoryURL_Mirror = URL(string: "https://gitlab.com/FlipByBlink/LockInNote_Mirror")!

enum 📁SourceFolder: String, CaseIterable, Identifiable {
    case main
    case 🧰Others
    var id: Self { self }
}
