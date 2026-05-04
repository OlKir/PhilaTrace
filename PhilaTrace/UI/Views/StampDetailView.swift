import SwiftUI

struct StampDetailView: View {
    let stamp: Stamp

    var body: some View {
        ZStack {
            LiquidBackgroundView()

            ScrollView {
                VStack(spacing: 22) {
                    stampImage

                    infoTable
                }
                .padding(.horizontal, 24)
                .padding(.top, 12)
                .padding(.bottom, 40)
            }
        }
        .navigationTitle(stamp.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var stampImage: some View {
        GeometryReader { proxy in
            ZStack {
                if let imageName = stamp.imageName {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                } else {
                    Rectangle().fill(gradient)
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .strokeBorder(.white.opacity(0.12), lineWidth: 1)
            }
        }
        .frame(height: UIScreen.main.bounds.height * 0.42)
    }

    private var infoTable: some View {
        VStack(spacing: 0) {
            infoRow(label: "Title", value: stamp.title)
            divider
            infoRow(label: "Country", value: stamp.country)
            divider
            infoRow(label: "Year", value: String(stamp.year))
        }
        .padding(.vertical, 4)
        .liquidGlass(cornerRadius: 22)
    }

    private func infoRow(label: String, value: String) -> some View {
        HStack(alignment: .firstTextBaseline) {
            Text(label.uppercased())
                .font(.system(.caption2).weight(.bold))
                .tracking(2.0)
                .foregroundStyle(LiquidTheme.onSurfaceVariant.opacity(0.85))
                .frame(width: 96, alignment: .leading)

            Spacer(minLength: 12)

            Text(value)
                .font(.system(.subheadline).weight(.semibold))
                .foregroundStyle(LiquidTheme.primary.opacity(0.95))
                .multilineTextAlignment(.trailing)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 14)
    }

    private var divider: some View {
        Rectangle()
            .fill(.white.opacity(0.08))
            .frame(height: 1)
            .padding(.horizontal, 18)
    }

    private var gradient: LinearGradient {
        switch stamp.coverStyle {
        case .aurora:
            LinearGradient(colors: [LiquidTheme.primaryGlow.opacity(0.45), Color.purple.opacity(0.30), LiquidTheme.surface], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .sunset:
            LinearGradient(colors: [LiquidTheme.secondaryGlow.opacity(0.40), Color.orange.opacity(0.28), LiquidTheme.surface], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .emerald:
            LinearGradient(colors: [LiquidTheme.tertiaryGlow.opacity(0.40), Color.teal.opacity(0.28), LiquidTheme.surface], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
}

#Preview {
    NavigationStack {
        StampDetailView(stamp: StampsAlbum.samples[0].pages[0].stamps[0])
    }
}
