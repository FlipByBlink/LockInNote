
import SwiftUI
import StoreKit

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

struct 📣ADMenu: View {
    @EnvironmentObject var 🛒: 🛒StoreModel
    
    var body: some View {
        List {
            Section {
                Text("This App shows banner advertisement about applications on AppStore. These are several Apps by this app's developer. It is activated after you launch this app 5 times.")
                    .padding()
                    .textSelection(.enabled)
            } header: {
                Text("Description")
            }
            
            🛒IAPSection()
            
            Section {
                ForEach(📣AppName.allCases) { 🏷 in
                    📣ADView(🏷)
                }
            }
        }
        .navigationTitle("AD / Purchase")
    }
}


struct 📣ADView: View {
    @State private var ⓐppName: 📣AppName
    
    var body: some View {
        Link(destination: ⓐppName.🔗URL) {
            HStack(spacing: 12) {
                Image(ⓐppName.rawValue)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(radius: 1.5, y: 0.5)
                    .padding(.vertical, 40)
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Text(ⓐppName.rawValue)
                            .font(.headline)
                            .lineLimit(1)
                        Image(systemName: "arrow.up.forward.app")
                            .resizable()
                            .frame(width: 15, height: 15)
                    }
                    .minimumScaleFactor(0.1)
                    .padding(.trailing, 32)
                    
                    Text(ⓐppName.📄About)
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                        .minimumScaleFactor(0.1)
                }
                .padding(.vertical)
            }
        }
        .accessibilityLabel("Open AD link")
        .padding(.leading, 4)
        .overlay(alignment: .topLeading) {
            Text("AD")
                .scaleEffect(x: 1.2)
                .font(.subheadline.weight(.black))
                .frame(maxHeight: 32)
                .minimumScaleFactor(0.1)
                .padding(.top, 8)
                .padding(.leading, 3)
                .foregroundStyle(.tertiary)
        }
    }
    
    init(_ ⓐppName: 📣AppName = 📣AppName.allCases.randomElement()!) {
        self.ⓐppName = ⓐppName
    }
    
    init(without: 📣AppName) {
        let ⓐpps = 📣AppName.allCases.filter { $0 != without }
        ⓐppName = ⓐpps.randomElement()!
    }
}


enum 📣AppName: String, CaseIterable, Identifiable {
    case FlipByBlink
    case FadeInAlarm
    case Plain将棋盤
    case TapWeight
    case TapTemperature
    case MemorizeWidget
    
    var id: String { self.rawValue }
    
    var 🔗URL: URL {
        switch self {
            case .FlipByBlink: return URL(string: "https://apps.apple.com/app/id1444571751")!
            case .FadeInAlarm: return URL(string: "https://apps.apple.com/app/id1465336070")!
            case .Plain将棋盤: return URL(string: "https://apps.apple.com/app/id1620268476")!
            case .TapWeight: return URL(string: "https://apps.apple.com/app/id1624159721")!
            case .TapTemperature: return URL(string: "https://apps.apple.com/app/id1626760566")!
            case .MemorizeWidget: return URL(string: "https://apps.apple.com/app/id1644276262")!
        }
    }
    
    var 📄About: LocalizedStringKey {
        switch self {
            case .FlipByBlink: return "Simple and normal ebook reader (for fixed-layout). Only a special feature. Turn a page with slightly longish voluntary blink."
            case .FadeInAlarm: return "Alarm clock with taking a long time from small volume to max volume."
            case .Plain将棋盤: return "Simple Shogi board App. Based on iOS system UI design."
            case .TapWeight: return "Register weight data to the Apple \"Health\" application pre-installed on iPhone in the fastest possible way (as manual)."
            case .TapTemperature: return "Register body temperature data to the \"Health\" app pre-installed on iPhone in the fastest possible way (as manual)."
            case .MemorizeWidget: return "Flashcard on widget. Memorize a note in everyday life."
        }
    }
}
