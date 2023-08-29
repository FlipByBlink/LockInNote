import SwiftUI

struct 🎚️SystemWidgetPreview: View {
    @EnvironmentObject var note: 📝NoteModel
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 8) {
                Group {
                    switch self.note.system_appearanceMode {
                        case .standard:
                            HStack(spacing: 12) {
                                Group {
                                    🪧SystemFamilyView(isPreview: true)
                                        .environment(\.colorScheme, .light)
                                    🪧SystemFamilyView(isPreview: true)
                                        .environment(\.colorScheme, .dark)
                                }
                                .frame(width: 160, height: 160)
                                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                            }
                            .padding(.horizontal, 8)
                        case .color:
                            🪧SystemFamilyView(isPreview: true)
                                .frame(width: 160, height: 160)
                                .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                    }
                }
                .shadow(color: .gray, radius: 4)
                Text("Preview")
                    .foregroundStyle(.secondary)
                    .tracking(0.5)
                    .font(.subheadline.italic().weight(.light))
            }
            .frame(height: 180)
            .padding(8)
            Spacer()
        }
        .listRowBackground(Color.clear)
    }
}

struct 🎚️AccessoryWidgetPreview: View {
    var body: some View {
        HStack {
            Spacer()
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(.gray.opacity(0.5).gradient)
                    🪧AccessoryFamilyView(isPreview: true)
                }
#if os(iOS) || os(macOS)
                .frame(width: 210, height: 80)
#elseif os(watchOS)
                .frame(width: 130, height: 70)
#endif
                Text("Preview")
                    .foregroundStyle(.secondary)
                    .tracking(0.5)
                    .font(.subheadline.italic().weight(.light))
            }
            Spacer()
        }
#if os(iOS) || os(macOS)
        .padding(.vertical, 32)
#elseif os(watchOS)
        .padding(.vertical, 8)
#endif
        .listRowBackground(Color.clear)
    }
}

struct 🎚️EmptyContentPreview: View {
    var body: some View {
        Section {
            HStack {
                Spacer()
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(.gray.opacity(0.5).gradient)
                        🪧EmptyContentView()
#if os(iOS) || os(macOS)
                            .font(.title)
#elseif os(watchOS)
                            .font(.title3)
#endif
                    }
#if os(iOS) || os(macOS)
                    .frame(width: 120, height: 120)
#elseif os(watchOS)
                    .frame(width: 60, height: 60)
#endif
                    Text("Preview")
                        .foregroundStyle(.secondary)
                        .tracking(0.5)
                        .font(.subheadline.italic().weight(.light))
                }
                Spacer()
            }
#if os(iOS) || os(macOS)
            .padding(.vertical, 32)
#elseif os(watchOS)
            .padding(.vertical, 4)
#endif
            .listRowBackground(Color.clear)
        }
    }
}
