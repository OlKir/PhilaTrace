import SwiftUI

struct AlbumDetailsView: View {
    let album: StampsAlbum

    var body: some View {
        ZStack {
            LiquidBackgroundView()

            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    topHero
                        .padding(.top, 12)

                    perforationDivider
                        .padding(.vertical, 14)

                    pagesSection
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 140)
            }
            .overlay(alignment: .bottomTrailing) {
                floatingAction
                    .padding(.trailing, 24)
                    .padding(.bottom, 40)
            }
            .safeAreaInset(edge: .bottom) {
                stickyCTA
            }
        }
        .navigationTitle("Album Details")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var topHero: some View {
        HStack(alignment: .top, spacing: 14) {
            VStack(alignment: .leading, spacing: 12) {
                Text(album.title)
                    .font(.system(.largeTitle, design: .rounded).weight(.bold))
                    .glossyText()

                HStack(spacing: 10) {
                    Text(album.yearRange.uppercased())
                        .font(.system(.caption).weight(.semibold))
                        .tracking(2.0)
                        .foregroundStyle(LiquidTheme.onSurfaceVariant.opacity(0.9))

                    HStack(spacing: 6) {
                        Circle()
                            .fill(LiquidTheme.primaryGlow)
                            .frame(width: 6, height: 6)
                        Text("\(album.itemCount) STAMPS")
                            .font(.system(.caption).weight(.semibold))
                            .tracking(2.0)
                            .foregroundStyle(LiquidTheme.onSurfaceVariant.opacity(0.9))
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Button { } label: {
                Image(systemName: "pencil")
                    .font(.system(.title3, design: .rounded).weight(.semibold))
                    .foregroundStyle(LiquidTheme.primary)
                    .frame(width: 52, height: 52)
                    .liquidGlass(cornerRadius: 22)
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Edit album")
        }
    }

    private var perforationDivider: some View {
        HStack(spacing: 10) {
            ForEach(0..<18, id: \.self) { _ in
                RoundedRectangle(cornerRadius: 2, style: .continuous)
                    .fill(.white.opacity(0.10))
                    .frame(width: 10, height: 4)
            }
        }
        .frame(maxWidth: .infinity)
        .accessibilityHidden(true)
    }

    private var pagesSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .firstTextBaseline) {
                Text("Album Pages")
                    .font(.system(.title3, design: .rounded).weight(.semibold))
                    .foregroundStyle(LiquidTheme.primary.opacity(0.85))

                Spacer()

                Button { } label: {
                    HStack(spacing: 6) {
                        Text("Sort by Date".uppercased())
                            .font(.system(.caption2).weight(.bold))
                            .tracking(2.2)
                        Image(systemName: "chevron.down")
                            .font(.system(size: 12, weight: .semibold))
                    }
                    .foregroundStyle(LiquidTheme.primary.opacity(0.6))
                }
                .buttonStyle(.plain)
            }

            LazyVGrid(columns: [GridItem(.flexible(), spacing: 14), GridItem(.flexible(), spacing: 14)], spacing: 14) {
                ForEach(album.pages) { page in
                    NavigationLink {
                        AlbumPageView(page: page)
                    } label: {
                        AlbumPageCardView(page: page)
                    }
                    .buttonStyle(.plain)
                }
                NewPagePlaceholderView()
            }
        }
    }

    private var floatingAction: some View {
        Button { } label: {
            Image(systemName: "books.vertical.fill")
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(LiquidTheme.surface)
                .frame(width: 64, height: 64)
                .background(LiquidTheme.primary)
                .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                .shadow(color: LiquidTheme.primaryGlow.opacity(0.35), radius: 20, x: 0, y: 10)
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Add to library")
    }

    private var stickyCTA: some View {
        VStack(spacing: 0) {
            Button { } label: {
                HStack(spacing: 10) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 18, weight: .bold))
                    Text("Add New Album Page")
                        .font(.system(.caption).weight(.bold))
                        .tracking(2.4)
                        .textCase(.uppercase)
                }
                .foregroundStyle(LiquidTheme.surface)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(LiquidTheme.primary.opacity(0.92))
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: .black.opacity(0.35), radius: 26, x: 0, y: 18)
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 24)
            .padding(.vertical, 14)
            .background(.ultraThinMaterial)
        }
    }
}

private struct AlbumPageCardView: View {
    let page: AlbumPage

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Color.clear
                .aspectRatio(3 / 4, contentMode: .fit)
                .overlay {
                    if let imageName = page.imageName {
                        Image(imageName)
                            .resizable()
                            .scaledToFill()
                    } else {
                        Rectangle().fill(gradient)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                .overlay {
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .strokeBorder(.white.opacity(0.10), lineWidth: 1)
                }
                .overlay(alignment: .bottom) {
                    LinearGradient(colors: [.black.opacity(0.60), .clear], startPoint: .bottom, endPoint: .top)
                        .opacity(0.2)
                }

            Text(page.title)
                .font(.system(.subheadline).weight(.semibold))
                .foregroundStyle(LiquidTheme.primary.opacity(0.9))
                .lineLimit(1)

            Text(page.mountedCountText.uppercased())
                .font(.system(.caption2).weight(.bold))
                .tracking(2.0)
                .foregroundStyle(LiquidTheme.onSurfaceVariant.opacity(0.85))
                .lineLimit(1)
        }
        .padding(14)
        .liquidGlass(cornerRadius: 26)
    }

    private var gradient: LinearGradient {
        switch page.coverStyle {
        case .aurora:
            LinearGradient(colors: [LiquidTheme.primaryGlow.opacity(0.45), Color.purple.opacity(0.30), LiquidTheme.surface], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .sunset:
            LinearGradient(colors: [LiquidTheme.secondaryGlow.opacity(0.40), Color.orange.opacity(0.28), LiquidTheme.surface], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .emerald:
            LinearGradient(colors: [LiquidTheme.tertiaryGlow.opacity(0.40), Color.teal.opacity(0.28), LiquidTheme.surface], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
}

private struct NewPagePlaceholderView: View {
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(LiquidTheme.primary.opacity(0.10))
                    .frame(width: 56, height: 56)
                Image(systemName: "plus")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(LiquidTheme.primary)
            }
            Text("New Page")
                .font(.system(.caption2).weight(.bold))
                .tracking(2.4)
                .textCase(.uppercase)
                .foregroundStyle(LiquidTheme.primary.opacity(0.6))
        }
        .frame(maxWidth: .infinity)
        .aspectRatio(3 / 4, contentMode: .fit)
        .padding(14)
        .overlay {
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .strokeBorder(LiquidTheme.primary.opacity(0.22), style: StrokeStyle(lineWidth: 2, dash: [8, 8]))
        }
        .background(.clear)
    }
}

#Preview {
    NavigationStack {
        AlbumDetailsView(album: StampsAlbum.samples[0])
            .toolbarBackground(.hidden, for: .navigationBar)
    }
}
