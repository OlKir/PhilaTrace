import SwiftUI

struct AddNewAlbumView: View {
    enum Mode: Equatable {
        case add
        case edit(StampsAlbum)
    }

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var albumsStore: AlbumsStore

    @State private var albumTitle: String = ""
    @State private var yearRange: String = ""
    @State private var selectedCoverStyle: AlbumCoverStyle = .aurora

    private let mode: Mode

    init(mode: Mode = .add) {
        self.mode = mode

        switch mode {
        case .add:
            break
        case .edit(let album):
            _albumTitle = State(initialValue: album.title)
            _yearRange = State(initialValue: album.yearRange)
            _selectedCoverStyle = State(initialValue: album.coverStyle)
        }
    }

    var body: some View {
        ZStack {
            LiquidBackgroundView()

            ScrollView {
                VStack(alignment: .leading, spacing: 22) {
                    hero
                        .padding(.top, 12)

                    VStack(alignment: .leading, spacing: 18) {
                        FloatingLabelField(
                            title: "Album Title",
                            placeholder: "e.g., British Colonies",
                            text: $albumTitle
                        )

                        FloatingLabelField(
                            title: "Year Range",
                            placeholder: "e.g., 1840-1900",
                            trailingSystemImage: "calendar",
                            text: $yearRange
                        )

                        createButton
                            .padding(.top, 6)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 140)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") { dismiss() }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(submitButtonTitle) { submit() }
                    .fontWeight(.semibold)
            }
        }
    }

    private var hero: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [LiquidTheme.primaryGlow.opacity(0.35), LiquidTheme.surface, Color.black.opacity(0.7)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: 210)
                .overlay {
                    RoundedRectangle(cornerRadius: 26, style: .continuous)
                        .strokeBorder(.white.opacity(0.12), lineWidth: 1)
                }
                .overlay(alignment: .topLeading) {
                    Circle()
                        .fill(LiquidTheme.primary.opacity(0.06))
                        .frame(width: 260, height: 260)
                        .blur(radius: 22)
                        .offset(x: -60, y: -120)
                }

            LinearGradient(colors: [.black.opacity(0.75), .clear], startPoint: .bottom, endPoint: .top)
                .frame(height: 130)
                .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))

            VStack(alignment: .leading, spacing: 6) {
                Text("Curation")
                    .font(.system(.caption2).weight(.bold))
                    .tracking(2.6)
                    .foregroundStyle(LiquidTheme.primaryGlow)
                    .textCase(.uppercase)
                Text("Begin Your Archive")
                    .font(.system(.title3, design: .rounded).weight(.semibold))
                    .foregroundStyle(.white)
            }
            .padding(18)
        }
        .liquidGlass(cornerRadius: 26)
    }

    

    private var createButton: some View {
        Button { submit() } label: {
            Text(submitButtonTitle.uppercased())
                .font(.system(.callout).weight(.bold))
                .tracking(2.2)
                .textCase(.uppercase)
                .foregroundStyle(LiquidTheme.surface)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(
                    LinearGradient(
                        colors: [LiquidTheme.primaryGlow, Color(red: 0x00 / 255, green: 0xF0 / 255, blue: 0xFF / 255), LiquidTheme.primary.opacity(0.95)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                .shadow(color: LiquidTheme.primaryGlow.opacity(0.25), radius: 26, x: 0, y: 18)
        }
        .buttonStyle(.plain)
    }

    private var submitButtonTitle: String {
        switch mode {
        case .add:
            return "Create"
        case .edit:
            return "Save"
        }
    }

    private func submit() {
        let didSubmit: Bool
        switch mode {
        case .add:
            didSubmit = albumsStore.addAlbum(title: albumTitle, yearRange: yearRange, coverStyle: selectedCoverStyle)
        case .edit(let album):
            didSubmit = albumsStore.updateAlbum(id: album.id, title: albumTitle, yearRange: yearRange, coverStyle: selectedCoverStyle)
        }

        if didSubmit {
            dismiss()
        }
    }
}

private struct FloatingLabelField: View {
    let title: String
    let placeholder: String
    var trailingSystemImage: String?
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.system(.caption2).weight(.bold))
                .tracking(2.4)
                .textCase(.uppercase)
                .foregroundStyle(LiquidTheme.onSurfaceVariant.opacity(0.85))
                .padding(.leading, 4)

            HStack(spacing: 10) {
                TextField(placeholder, text: $text)
                    .textInputAutocapitalization(.words)
                    .autocorrectionDisabled()
                    .foregroundStyle(.white)
                    .tint(LiquidTheme.primaryGlow)

                if let trailingSystemImage {
                    Image(systemName: trailingSystemImage)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(LiquidTheme.primaryGlow.opacity(0.6))
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .liquidGlass(cornerRadius: 18)
        }
    }
}

private struct CollectionTypeCard: View {
    let title: String
    let subtitle: String
    let systemImage: String
    let isSelected: Bool
    var onTap: (() -> Void)?

    var body: some View {
        Button { onTap?() } label: {
            HStack(spacing: 12) {
                Image(systemName: systemImage)
                    .font(.system(.title3, design: .rounded).weight(.semibold))
                    .foregroundStyle(isSelected ? LiquidTheme.primaryGlow : LiquidTheme.onSurfaceVariant.opacity(0.9))
                    .frame(width: 36, height: 36)
                    .background((isSelected ? LiquidTheme.primaryGlow.opacity(0.12) : Color.white.opacity(0.06)), in: RoundedRectangle(cornerRadius: 14, style: .continuous))

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(.subheadline, design: .rounded).weight(.semibold))
                        .foregroundStyle(.white)
                    Text(subtitle.uppercased())
                        .font(.system(.caption2).weight(.bold))
                        .tracking(2.2)
                        .foregroundStyle((isSelected ? LiquidTheme.primaryGlow : LiquidTheme.onSurfaceVariant).opacity(0.75))
                }
                Spacer(minLength: 0)
            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .liquidGlass(cornerRadius: 26)
            .overlay {
                if isSelected {
                    RoundedRectangle(cornerRadius: 26, style: .continuous)
                        .strokeBorder(LiquidTheme.primaryGlow.opacity(0.35), lineWidth: 1)
                }
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        AddNewAlbumView()
            .toolbarBackground(.hidden, for: .navigationBar)
    }
    .environmentObject(AlbumsStore())
}
