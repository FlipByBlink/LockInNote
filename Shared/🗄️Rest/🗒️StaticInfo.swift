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
    static let versionInfos: [(version: String, date: String)] = [("1.2", "2023-09-01"),
                                                                  ("1.1", "2023-03-28"),
                                                                  ("1.0.4", "2023-01-30"),
                                                                  ("1.0.3", "2022-12-09"),
                                                                  ("1.0.2", "2022-11-08"),
                                                                  ("1.0.1", "2022-09-15"),
                                                                  ("1.0", "2022-09-13")] //降順。先頭の方が新しい
    
    enum SourceCodeCategory: String, CaseIterable, Identifiable {
        case main, Widget, URLSchemeAction, Rest
        var id: Self { self }
        var fileNames: [String] {
            switch self {
                case .main: ["App.swift",
                             "ContentView.swift",
                             "📱AppModel.swift",
                             "📝NoteTab.swift",
                             "📝NoteProperty.swift",
                             "📝NoteModel.swift",
                             "📝NoteFamily.swift",
                             "💾ICloud.swift",
                             "🎚️CustomizeModel.swift",
                             "🎚️CustomizeMenu.swift",
                             "🎚️CustomizeMenuComponent.swift",
                             "👆Buttons.swift",
                             "💬Sheet.swift",
                             "🔖Tab.swift",
                             "🛠️OptionTab.swift"]
                case .Widget: ["Widget.swift",
                               "WidgetBundle.swift",
                               "🪧WidgetView.swift"]
                case .URLSchemeAction: ["🔗Model.swift",
                                        "🔗MenuComponent.swift",
                                        "🔗Button.swift",
                                        "🔗URLSchemeActionMenu.swift"]
                case .Rest: ["🗒️StaticInfo.swift",
                             "ℹ️InfoTab.swift",
                             "💁WidgetGuideTab.swift",
                             "💬RequestUserReview.swift",
                             "ℹ️AboutApp.swift",
                             "📣ADModel.swift",
                             "📣ADComponents.swift",
                             "🛒InAppPurchaseModel.swift",
                             "🛒InAppPurchaseView.swift"]
            }
        }
    }
}

#elseif os(watchOS)
extension 🗒️StaticInfo {
    enum SourceCodeCategory: String, CaseIterable, Identifiable {
        case main, Complication, Rest
        var id: Self { self }
        var fileNames: [String] {
            switch self {
                case .main: ["App.swift",
                             "ContentView.swift",
                             "📱AppModel.swift",
                             "📝NoteTab.swift",
                             "📝NoteFamily.swift",
                             "📝NoteProperty.swift",
                             "📝NoteModel.swift",
                             "💾ICloud.swift",
                             "🎚️CustomizeModel.swift",
                             "🎚️CustomizeMenu.swift",
                             "🎚️CustomizeMenuComponent.swift",
                             "💬Sheet.swift",
                             "🔖Tab.swift",
                             "🛠️OptionTab.swift",
                             "ℹ️AboutApp.swift"]
                case .Complication: ["Widget.swift",
                                     "WidgetBundle.swift",
                                     "🪧WidgetView.swift"]
                case .Rest: ["🗒️StaticInfo.swift",
                             "ℹ️AboutApp.swift"]
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
        case main, Widget, URLSchemeAction, Rest
        var id: Self { self }
        var fileNames: [String] {
            switch self {
                case .main: ["App.swift",
                             "ContentView.swift",
                             "📱AppModel.swift",
                             "📝NoteView.swift",
                             "📝NoteWindow.swift",
                             "📝NoteFamily.swift",
                             "📝NoteProperty.swift",
                             "📝NoteModel.swift",
                             "💾ICloud.swift",
                             "🎚️CustomizeModel.swift",
                             "🎚️CustomizeMenu.swift",
                             "🎚️CustomizeMenuComponent.swift",
                             "💬Sheet.swift",
                             "🔧Settings.swift",
                             "🪄Commands.swift"]
                case .Widget: ["Widget.swift",
                               "WidgetBundle.swift",
                               "🪧WidgetView.swift"]
                case .URLSchemeAction: ["🔗Model.swift",
                                        "🔗Button.swift",
                                        "🔗Command.swift",
                                        "🔗Menu.swift",
                                        "🔗MenuComponent.swift"]
                case .Rest: ["🗒️StaticInfo.swift",
                             "ℹ️HelpWindows.swift",
                             "📣ADModel.swift",
                             "📣ADContent.swift",
                             "🛒InAppPurchaseModel.swift",
                             "🛒InAppPurchaseView.swift"]
            }
        }
    }
}
#endif
