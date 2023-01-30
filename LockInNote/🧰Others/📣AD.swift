import SwiftUI
import StoreKit

struct 📣ADSheet: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @EnvironmentObject var 🛒: 🛒StoreModel
    private var ⓐpp: 📣MyApp
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack { self.ⓒontent() }
        } else {
            NavigationView { self.ⓒontent() }
                .navigationViewStyle(.stack)
        }
    }
    private func ⓒontent() -> some View {
        Group {
            if self.verticalSizeClass == .regular {
                self.ⓥerticalLayout()
            } else {
                self.ⓗorizontalLayout()
            }
        }
        .modifier(Self.ⓟurchasedEffect())
        .navigationTitle("AD")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                self.ⓓismissButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                self.ⓐdMenuLink()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    private func ⓥerticalLayout() -> some View {
        VStack(spacing: 16) {
            Spacer()
            self.ⓜockImage()
            Spacer()
            self.ⓘcon()
            self.ⓝame()
            Spacer()
            self.ⓓescription()
            Spacer()
            self.ⓐppStoreBadge()
            Spacer()
        }
        .padding()
    }
    private func ⓗorizontalLayout() -> some View {
        HStack(spacing: 16) {
            self.ⓜockImage()
            VStack(spacing: 12) {
                Spacer()
                self.ⓘcon()
                self.ⓝame()
                self.ⓓescription()
                Spacer()
                self.ⓐppStoreBadge()
                Spacer()
            }
            .padding(.horizontal)
        }
        .padding()
    }
    private func ⓜockImage() -> some View {
        Link(destination: self.ⓐpp.url) {
            Image(self.ⓐpp.mockImageName)
                .resizable()
                .scaledToFit()
        }
        .accessibilityHidden(true)
        .disabled(🛒.🚩purchased)
    }
    private func ⓘcon() -> some View {
        Link(destination: self.ⓐpp.url) {
            Image(self.ⓐpp.iconImageName)
                .resizable()
                .frame(width: 60, height: 60)
        }
        .accessibilityHidden(true)
        .disabled(🛒.🚩purchased)
    }
    private func ⓝame() -> some View {
        Link(destination: self.ⓐpp.url) {
            Text(self.ⓐpp.name)
                .font(.headline)
        }
        .buttonStyle(.plain)
        .accessibilityHidden(true)
        .disabled(🛒.🚩purchased)
    }
    private func ⓓescription() -> some View {
        Text(self.ⓐpp.description)
            .font(.subheadline)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 8)
    }
    private func ⓐppStoreBadge() -> some View {
        Link(destination: self.ⓐpp.url) {
            HStack(spacing: 6) {
                Image("appstore_badge")
                Image(systemName: "hand.point.up.left")
            }
            .foregroundColor(.primary)
        }
        .accessibilityLabel("Open AppStore page")
        .disabled(🛒.🚩purchased)
    }
    private func ⓐdMenuLink() -> some View {
        NavigationLink {
            📣ADMenu()
                .navigationBarTitleDisplayMode(.large)
        } label: {
            Image(systemName: "questionmark.circle")
                .foregroundColor(.primary)
        }
        .accessibilityLabel("About AD")
    }
    private func ⓓismissButton() -> some View {
        Button {
            🛒.🚩showADSheet = false
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        } label: {
            Image(systemName: "chevron.down")
        }
        .foregroundStyle(.primary)
        .accessibilityLabel("Dismiss")
    }
    struct ⓟurchasedEffect: ViewModifier {
        @EnvironmentObject var 🛒: 🛒StoreModel
        func body(content: Content) -> some View {
            if 🛒.🚩purchased {
                content
                    .blur(radius: 6)
                    .overlay {
                        Image(systemName: "trash.square.fill")
                            .resizable()
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.white, .red)
                            .frame(width: 160, height: 160)
                            .rotationEffect(.degrees(5))
                            .shadow(radius: 12)
                    }
            } else {
                content
            }
        }
    }
    init(_ ⓐpp: 📣MyApp) {
        self.ⓐpp = ⓐpp
    }
}

struct 📣ADMenu: View {
    @EnvironmentObject var 🛒: 🛒StoreModel
    var body: some View {
        List {
            Section {
                Text("This App shows advertisement about applications on AppStore. These are several Apps by this app's developer. It is activated after you launch this app 5 times.")
                    .padding()
            } header: {
                Text("Description")
            }
            🛒IAPSection()
        }
        .navigationTitle("About AD")
    }
}

struct 📣ADMenuLink: View {
    @EnvironmentObject var 🛒: 🛒StoreModel
    var body: some View {
        Section {
            🛒PurchaseView()
            NavigationLink {
                📣ADMenu()
            } label: {
                Label("About AD / Purchase", systemImage: "megaphone")
            }
        } header: {
            Text("AD / Purchase")
        }
    }
}

enum 📣MyApp: String, CaseIterable {
    case FlipByBlink
    case FadeInAlarm
    case PlainShogiBoard
    case TapWeight
    case TapTemperature
    case MemorizeWidget
    case LockInNote
    
    var name: LocalizedStringKey {
        LocalizedStringKey(self.rawValue)
    }
    
    var url: URL {
        switch self {
            case .FlipByBlink: return URL(string: "https://apps.apple.com/app/id1444571751")!
            case .FadeInAlarm: return URL(string: "https://apps.apple.com/app/id1465336070")!
            case .PlainShogiBoard: return URL(string: "https://apps.apple.com/app/id1620268476")!
            case .TapWeight: return URL(string: "https://apps.apple.com/app/id1624159721")!
            case .TapTemperature: return URL(string: "https://apps.apple.com/app/id1626760566")!
            case .MemorizeWidget: return URL(string: "https://apps.apple.com/app/id1644276262")!
            case .LockInNote: return URL(string: "https://apps.apple.com/app/id1644879340")!
        }
    }
    
    var description: LocalizedStringKey {
        switch self {
            case .FlipByBlink: return "Simple and normal ebook reader (for fixed-layout). Only a special feature. Turn a page with slightly longish voluntary blink."
            case .FadeInAlarm: return "Alarm clock with taking a long time from small volume to max volume."
            case .PlainShogiBoard: return "Simple Shogi board App. Based on iOS system UI design. Supported SharePlay."
            case .TapWeight: return "Register weight data to the Apple \"Health\" application pre-installed on iPhone in the fastest possible way (as manual)."
            case .TapTemperature: return "Register body temperature data to the \"Health\" app pre-installed on iPhone in the fastest possible way (as manual)."
            case .MemorizeWidget: return "Flashcard on widget. Memorize a note in everyday life."
            case .LockInNote: return "Notes widget on lock screen."
        }
    }
    
    var mockImageName: String {
        "mock/" + self.rawValue
    }
    
    var iconImageName: String {
        "icon/" + self.rawValue
    }
    
    static func pickUpAppWithout(_ ⓜySelf: Self) -> Self {
        let ⓐpps = 📣MyApp.allCases.filter { $0 != ⓜySelf }
        return ⓐpps.randomElement()!
    }
}
