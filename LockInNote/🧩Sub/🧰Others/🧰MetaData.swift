import Foundation

let 📜versionInfos = 📜VersionInfo.history(("1.1", "2023-03-28"),
                                           ("1.0.4", "2023-01-30"),
                                           ("1.0.3", "2022-12-09"),
                                           ("1.0.2", "2022-11-08"),
                                           ("1.0.1", "2022-09-15"),
                                           ("1.0", "2022-09-13")) //降順。先頭の方が新しい

let 🔗appStoreProductURL = URL(string: "https://apps.apple.com/app/id1644879340")!

let 👤privacyPolicyDescription = """
2022-09-12


English

This application don't collect user infomation.


(日本語)Japanese

このアプリ自身において、ユーザーの情報を一切収集しません。
"""

let 🔗webRepositoryURL = URL(string: "https://github.com/FlipByBlink/LockInNote")!
let 🔗webMirrorRepositoryURL = URL(string: "https://gitlab.com/FlipByBlink/LockInNote_Mirror")!

enum 📁SourceCodeCategory: String, CaseIterable, Identifiable {
    case main, Shared, Sub, Others, Widget, WatchApp
    var id: Self { self }
    var fileNames: [String] {
        switch self {
            case .main:
                return ["LockInNoteApp.swift",
                        "📱AppModel_iOS.swift",
                        "ContentView_iOS.swift"]
            case .Shared:
                return ["♻️BaseModel.swift",
                        "💾UserDefaults.swift",
                        "🔖Tab.swift"]
            case .Sub:
                return ["🛠MenuTab.swift",
                        "🔗URLSchemeAction.swift",
                        "💁WidgetGuideTab.swift",
                        "📣ADSheet.swift",
                        "💬RequestUserReview.swift"]
            case .Others:
                return ["🧰MetaData.swift",
                        "ℹ️AboutApp.swift",
                        "📣AD.swift",
                        "🛒InAppPurchase.swift"]
            case .Widget:
                return ["LINWidget.swift"]
            case .WatchApp:
                return ["LIN_Watch_App.swift",
                        "📱AppModel_watchOS.swift",
                        "ContentView_watchOS.swift"]
        }
    }
}
