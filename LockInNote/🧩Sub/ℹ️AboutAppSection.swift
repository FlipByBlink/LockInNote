import SwiftUI

struct ℹ️AboutAppSection: View {
    var body: some View {
        Section {
            GeometryReader { 📐 in
                VStack(spacing: 12) {
                    Image("RoundedIcon")
                        .resizable()
                        .frame(width: 100, height: 100)
                    VStack(spacing: 6) {
                        Text("LockInNote")
                            .font(.system(.title2, design: .rounded))
                            .fontWeight(.bold)
                            .tracking(1.5)
                            .opacity(0.75)
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                        Text("App for iPhone")
                            .font(.footnote)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                    }
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                }
                .padding(20)
                .padding(.top, 8)
                .frame(width: 📐.size.width)
            }
            .frame(height: 200)
            🔗AppStoreLink()
            NavigationLink  {
                ℹ️AboutAppMenu()
            } label: {
                Label("About App", systemImage: "doc")
            }
        }
    }
}
