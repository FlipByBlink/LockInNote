import SwiftUI

enum 🗒️StaticInfo {
    static let appName: LocalizedStringKey = "LockInNote"
    static let appSubTitle: LocalizedStringKey = "App for iPhone / iPad / Mac / Apple Watch"
    
    static let appStoreProductURL = URL(string: "https://apps.apple.com/app/id1644879340")!
    static var appStoreUserReviewURL: URL { .init(string: "\(Self.appStoreProductURL)?action=write-review")! }
    
    static var contactAddress: String { "sear_pandora_0x@icloud.com" }
    
    static let privacyPolicyDescription = """
        2022-09-12
        
        
        English
        
        This application don't collect user infomation.
        
        
        (日本語)Japanese
        
        このアプリ自身において、ユーザーの情報を一切収集しません。
        """
    
    static let webRepositoryURL = URL(string: "https://github.com/FlipByBlink/LockInNote")!
    static let webMirrorRepositoryURL = URL(string: "https://gitlab.com/FlipByBlink/LockInNote_Mirror")!
}

#if os(iOS)
extension 🗒️StaticInfo {
    static let versionInfos: [(version: String, date: String)] = [("1.1", "2023-03-28"),
                                                                  ("1.0.4", "2023-01-30"),
                                                                  ("1.0.3", "2022-12-09"),
                                                                  ("1.0.2", "2022-11-08"),
                                                                  ("1.0.1", "2022-09-15"),
                                                                  ("1.0", "2022-09-13")] //降順。先頭の方が新しい
    
    enum SourceCodeCategory: String, CaseIterable, Identifiable {
        case main, Sub, Rest, Widget
        var id: Self { self }
        var fileNames: [String] {
            switch self {
                case .main: ["App.swift",
                             "ContentView.swift",
                             "📱AppModel.swift",
                             "♻️BaseModel.swift"]
                case .Sub: ["💾UserDefaults.swift",
                            "🔖TabModel.swift",
                            "🔖TabView.swift",
                            "📝WidgetTab.swift",
                            "👆Buttons.swift",
                            "🛠️ViewCustomize.swift",
                            "🔗WidgetLink.swift",
                            "🛠MenuTab.swift",
                            "🔗URLSchemeAction.swift",
                            "💁WidgetGuideTab.swift",
                            "💬RequestUserReview.swift"]
                case .Rest: ["🗒️StaticInfo.swift",
                             "ℹ️AboutApp.swift",
                             "📣ADModel.swift",
                             "📣ADComponents.swift",
                             "🛒InAppPurchaseModel.swift",
                             "🛒InAppPurchaseView.swift"]
                case .Widget: ["Widget.swift",
                               "🖼️View.swift"]
            }
        }
    }
}

#elseif os(watchOS)
extension 🗒️StaticInfo {
    enum SourceCodeCategory: String, CaseIterable, Identifiable {
        case main, Sub, Rest, Complication
        var id: Self { self }
        var fileNames: [String] {
            switch self {
                case .main: ["App.swift",
                             "ContentView.swift",
                             "📱AppModel.swift"]
                case .Sub: []
                case .Rest: ["🗒️StaticInfo.swift",
                             "ℹ️AboutApp.swift"]
                case .Complication: ["Widget.swift",
                                     "🖼️View.swift"]
            }
        }
    }
}

#elseif os(macOS)
extension 🗒️StaticInfo {
    static let versionInfos: [(version: String, date: String)] = [("1.1", "2021-03-01"),
                                                                  ("1.0.1", "2021-02-01"),
                                                                  ("1.0", "2021-01-01")] //降順。先頭の方が新しい
    
    enum SourceCodeCategory: String, CaseIterable, Identifiable {
        case main, Sub, Rest, Widget
        var id: Self { self }
        var fileNames: [String] {
            switch self {
                case .main: ["App.swift",
                             "ContentView.swift",
                             "📱AppModel.swift"]
                case .Sub: ["📣ADSheet.swift",
                            "🔧Settings.swift",
                            "🪄Commands.swift",
                            "💬RequestUserReview.swift"]
                case .Rest: ["🗒️StaticInfo.swift",
                             "ℹ️HelpWindows.swift",
                             "📣ADModel.swift",
                             "📣ADContent.swift",
                             "🛒InAppPurchaseModel.swift",
                             "🛒InAppPurchaseView.swift"]
                case .Widget: ["Widget.swift",
                               "🖼️View.swift"]
            }
        }
    }
}
#endif
