import SwiftUI

enum 🗒️StaticInfo {
    static let appName: LocalizedStringResource = "LockInNote"
    static var appSubTitle: LocalizedStringResource {
        """
        iPhone, iPad, Apple Watch,
        Mac, Apple Vision Pro
        """
    }
    
    static let appStoreProductURL = URL(string: "https://apps.apple.com/app/id1644879340")!
    static var appStoreUserReviewURL: URL { .init(string: "\(Self.appStoreProductURL)?action=write-review")! }
    
    static var contactAddress: String { "sear_pandora_0x@icloud.com" }
    
    static let privacyPolicyDescription = """
        2022-09-12
        
        
        English
        
        This application don't collect user information.
        
        
        (日本語)Japanese
        
        このアプリ自身において、ユーザーの情報を一切収集しません。
        """
    
    static let webRepositoryURL = URL(string: "https://github.com/FlipByBlink/LockInNote")!
    static let webMirrorRepositoryURL = URL(string: "https://gitlab.com/FlipByBlink/LockInNote_Mirror")!
}

#if os(iOS) || os(visionOS)
extension 🗒️StaticInfo {
#if os(iOS)
    static let versionInfos: [(version: String, date: String)] = [
        ("1.2", "2023-09-14"),
        ("1.1", "2023-03-28"),
        ("1.0.4", "2023-01-30"),
        ("1.0.3", "2022-12-09"),
        ("1.0.2", "2022-11-08"),
        ("1.0.1", "2022-09-15"),
        ("1.0", "2022-09-13")
    ] //降順。先頭の方が新しい
#elseif os(visionOS)
    static let versionInfos: [(version: String, date: String)] = [
        ("1.3", "2025-09-11")
    ] //降順。先頭の方が新しい
#endif
    
    enum SourceCodeCategory: String, CaseIterable, Identifiable {
        case main,
             Widget,
             WidgetView,
             Customize,
             CustomizeMenu,
             Rest,
             URLSchemeAction,
             Migration
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
                             "👆Buttons.swift",
                             "💬Sheet.swift",
                             "🔖Tab.swift",
                             "🛠️OptionTab.swift"]
                case .Widget: ["WidgetBundle.swift",
                               "Widget.swift"]
                case .WidgetView: ["🪧EntryView.swift",
                                   "🪧Situation.swift",
                                   "🪧SystemFamilyView.swift",
                                   "🪧AccessoryFamilyView.swift",
                                   "🪧AccessoryCornerView.swift",
                                   "🪧EmptyIconView.swift",
                                   "🪧PlaceholderView.swift",
                                   "🪧ContainerBackground.swift",
                                   "🪧SnapshotTitle.swift",
                                   "🪧SampleTextInApp.swift"]
                case .Customize: ["🎚️Model.swift",
                                  "🎚️MenuComponent.swift",
                                  "🎚️SaveValues.swift",
                                  "🎚️PreviewInApp.swift"]
                case .CustomizeMenu: ["🎚️CustomizeMenu.swift",
                                      "🎚️SharedOptionSection.swift",
                                      "🎚️SharedOptionPreview.swift",
                                      "🎚EmptyIconMenuLink.swift",
                                      "🎚️SystemWidgetMenuLink.swift",
                                      "🎚️AccessoryWidgetMenuLink.swift",
                                      "🎚️TitleTextFieldLink.swift",
                                      "🎚️DoubleSizeOnLargeWidgetMenuLink.swift",]
                case .Rest: {
                    var value = ["🗒️StaticInfo.swift",
                                 "📋AddNoteToEnvironment.swift",
                                 "🪧ReloadWidgetsOnActive.swift",
                                 "🛠️PreventAutomaticKeyboardOption.swift",
                                 "ℹ️InfoTab.swift",
                                 "💁HowToGuide.swift",
                                 "🅧DismissButtonLabel.swift",
                                 "💥Feedback.swift",
                                 "💬RequestUserReview.swift",
                                 "ℹ️AboutApp.swift",]
#if os(iOS)
                    value.append(contentsOf: ["📣ADModel.swift",
                                              "📣ADSheet.swift",
                                              "📣ADComponents.swift",
                                              "🛒InAppPurchaseModel.swift",
                                              "🛒InAppPurchaseView.swift",])
#elseif os(visionOS)
                    value.append("temporary.swift")
#endif
                    value.append("🚧DebugMenu.swift")
                    return value
                }()
                case .URLSchemeAction: ["🔗Model.swift",
                                        "🔗MenuComponent.swift",
                                        "🔗Button.swift",
                                        "🔗URLSchemeActionMenu.swift"]
                case .Migration: ["🗄️FromVer_1_1.swift",
                                  "♻️BaseModelVer_1_1.swift",
                                  "💾ICloudVer_1_1.swift"]
            }
        }
    }
}

#elseif os(watchOS)
extension 🗒️StaticInfo {
    enum SourceCodeCategory: String, CaseIterable, Identifiable {
        case main, Complication, WidgetView, Customize, Rest, Migration
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
                             "📖NoteDetailView.swift",
                             "💬Sheet.swift",
                             "🔖Tab.swift"]
                case .Complication: ["WidgetBundle.swift",
                                     "Widget.swift"]
                case .WidgetView: ["🪧EntryView.swift",
                                   "🪧Situation.swift",
                                   "🪧AccessoryFamilyView.swift",
                                   "🪧AccessoryCornerView.swift",
                                   "🪧EmptyIconView.swift",
                                   "🪧PlaceholderView.swift",
                                   "🪧ContainerBackground.swift",
                                   "🪧SnapshotTitle.swift",
                                   "🪧SampleTextInApp.swift"]
                case .Customize: ["🎚️Model.swift",
                                  "🎚️CustomizeMenu.swift",
                                  "🎚️MenuComponent.swift",
                                  "🎚️SaveValues.swift",
                                  "🎚️PreviewInApp.swift"]
                case .Rest: ["🗒️StaticInfo.swift",
                             "📋AddNoteToEnvironment.swift",
                             "🪧ReloadWidgetsOnActive.swift",
                             "ℹ️InfoTab.swift",
                             "ℹ️AboutApp.swift"]
                case .Migration: ["🗄️FromVer_1_1.swift",
                                  "♻️BaseModelVer_1_1.swift",
                                  "💾ICloudVer_1_1.swift"]
            }
        }
    }
}

#elseif os(macOS)
extension 🗒️StaticInfo {
    static let versionInfos: [(version: String, date: String)] = [
        ("1.2", "2023-09-14"),
        ("1.4", "2025-10-12"),
    ] //降順。先頭の方が新しい
    
    enum SourceCodeCategory: String, CaseIterable, Identifiable {
        case main, Widget, WidgetView, Customize, URLSchemeAction, Commands, Rest
        var id: Self { self }
        var fileNames: [String] {
            switch self {
                case .main: ["App.swift",
                             "📱AppModel.swift",
                             "📝NoteWindow.swift",
                             "ContentView.swift",
                             "📝NoteEditor.swift",
                             "📝NoteFamily.swift",
                             "📝NoteProperty.swift",
                             "📝NoteModel.swift",
                             "💾ICloud.swift"]
                case .Widget: ["WidgetBundle.swift",
                               "Widget.swift"]
                case .WidgetView: ["🪧EntryView.swift",
                                   "🪧Situation.swift",
                                   "🪧SystemFamilyView.swift",
                                   "🪧EmptyIconView.swift",
                                   "🪧PlaceholderView.swift",
                                   "🪧ContainerBackground.swift",
                                   "🪧SnapshotTitle.swift",
                                   "🪧SampleTextInApp.swift"]
                case .Customize: ["🎚️Model.swift",
                                  "🎚️CustomizeWindow.swift",
                                  "🎚️CustomizeMenu.swift",
                                  "🎚️MenuComponent.swift",
                                  "🎚️SaveValues.swift",
                                  "🎚️PreviewInApp.swift"]
                case .URLSchemeAction: ["🔗Model.swift",
                                        "🔗Button.swift",
                                        "🔗Command.swift",
                                        "🔗Menu.swift",
                                        "🔗MenuComponent.swift"]
                case .Commands: ["🪄Commands.swift"]
                case .Rest: ["🗒️StaticInfo.swift",
                             "📋AddNoteToEnvironment.swift",
                             "🔲WindowEdgeFeedback.swift",
                             "ℹ️HelpWindows.swift",
                             "📣ADModel.swift",
                             "📣ADSheet.swift",
                             "📣ADContent.swift",
                             "🛒InAppPurchaseModel.swift",
                             "🛒InAppPurchaseWindow.swift",
                             "🛒InAppPurchaseMenu.swift"]
            }
        }
    }
}
#endif
