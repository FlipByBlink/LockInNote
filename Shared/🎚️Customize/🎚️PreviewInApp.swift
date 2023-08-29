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
                                    🪧SystemFamilyView()
                                        .environment(\.colorScheme, .light)
                                    🪧SystemFamilyView()
                                        .environment(\.colorScheme, .dark)
                                }
                                .frame(width: 160, height: 160)
                                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                            }
                            .padding(.horizontal, 8)
                        case .color:
                            🪧SystemFamilyView()
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
        .environment(\.ⓢituation, .previewInApp)
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
                    🪧AccessoryFamilyView()
                        .padding(.horizontal, 8)
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
        .environment(\.ⓢituation, .previewInApp)
    }
}

struct 🎚️EmptyIconPreview: View {
    var body: some View {
        Section {
            HStack {
                Spacer()
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(.gray.opacity(0.5).gradient)
                        🪧EmptyIconView()
                            .padding(.horizontal, 8)
                    }
#if os(iOS) || os(macOS)
                    .frame(width: 220, height: 160)
#elseif os(watchOS)
                    .frame(width: 90, height: 60)
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
            .environment(\.ⓢituation, .previewInApp)
        }
    }
}
