import SwiftUI

struct AddPageView: View {
    @State private var pageTitle: String = ""
    @State private var selectedTemplateIndex: Int = 0

    private let templates: [PageTemplateCard] = [
        PageTemplateCard(title: "Classic Mount", subtitle: "Grid Layout", style: .aurora),
        PageTemplateCard(title: "Showcase", subtitle: "Single Hero", style: .sunset),
        PageTemplateCard(title: "Metadata", subtitle: "Notes + Grid", style: .emerald),
    ]

    var body: some View {
        ZStack {
            LiquidBackgroundView()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    header
                        .padding(.top, 12)

                    FloatingTemplatePicker(selectedIndex: $selectedTemplateIndex)

                    pageTitleField

                    templateGrid

                    Button { } label: {
                        HStack(spacing: 10) {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 18, weight: .bold))
                            Text("Add Page")
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
                    .padding(.top, 8)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 140)
            }
            .safeAreaInset(edge: .top) {
                topBar
            }
        }
    }

    private var topBar: some View {
        HStack(spacing: 12) {
            Button { } label: {
                Image(systemName: "chevron.left")
                    .font(.system(.headline, design: .rounded).weight(.semibold))
                    .foregroundStyle(LiquidTheme.primaryGlow)
                    .frame(width: 40, height: 40)
                    .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .overlay {
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .strokeBorder(.white.opacity(0.12), lineWidth: 1)
                    }
            }
            .buttonStyle(.plain)

            Text("New Page")
                .font(.system(.headline, design: .rounded).weight(.semibold))
                .foregroundStyle(.white)

            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 14)
        .background(.ultraThinMaterial)
        .overlay(alignment: .bottom) {
            Rectangle().fill(.white.opacity(0.08)).frame(height: 1)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Add Album Page")
                .font(.system(.largeTitle, design: .rounded).weight(.bold))
                .glossyText()
                .accessibilityAddTraits(.isHeader)

            Text("Choose a template and start mounting your next set of stamps.")
                .font(.system(.body))
                .foregroundStyle(LiquidTheme.onSurfaceVariant.opacity(0.9))
        }
    }

    private var pageTitleField: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Page Title")
                .font(.system(.caption2).weight(.bold))
                .tracking(2.4)
                .textCase(.uppercase)
                .foregroundStyle(LiquidTheme.onSurfaceVariant.opacity(0.85))
                .padding(.leading, 4)

            TextField("e.g., Great Britain (1840-41)", text: $pageTitle)
                .foregroundStyle(.white)
                .tint(LiquidTheme.primaryGlow)
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                .liquidGlass(cornerRadius: 18)
        }
    }

    private var templateGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible(), spacing: 14), GridItem(.flexible(), spacing: 14)], spacing: 14) {
            ForEach(Array(templates.enumerated()), id: \.offset) { index, template in
                PageTemplateCardView(template: template, isSelected: index == selectedTemplateIndex)
            }
            NewTemplatePlaceholderView()
        }
    }
}

private struct FloatingTemplatePicker: View {
    @Binding var selectedIndex: Int

    var body: some View {
        HStack {
            Text("Template")
                .font(.system(.caption2).weight(.bold))
                .tracking(2.4)
                .textCase(.uppercase)
                .foregroundStyle(LiquidTheme.onSurfaceVariant.opacity(0.85))

            Spacer()

            Button { } label: {
                HStack(spacing: 6) {
                    Text("Browse".uppercased())
                        .font(.system(.caption2).weight(.bold))
                        .tracking(2.2)
                    Image(systemName: "chevron.down")
                        .font(.system(size: 12, weight: .semibold))
                }
                .foregroundStyle(LiquidTheme.primary.opacity(0.6))
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .liquidGlass(cornerRadius: 22)
    }
}

private struct PageTemplateCard: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let style: AlbumCoverStyle
}

private struct PageTemplateCardView: View {
    let template: PageTemplateCard
    let isSelected: Bool

    var body: some View {
        Button { } label: {
            VStack(alignment: .leading, spacing: 10) {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(gradient)
                    .aspectRatio(1.05, contentMode: .fit)
                    .overlay {
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .strokeBorder(.white.opacity(0.10), lineWidth: 1)
                    }

                Text(template.title)
                    .font(.system(.subheadline, design: .rounded).weight(.semibold))
                    .foregroundStyle(.white)
                    .lineLimit(1)

                Text(template.subtitle.uppercased())
                    .font(.system(.caption2).weight(.bold))
                    .tracking(2.0)
                    .foregroundStyle(LiquidTheme.onSurfaceVariant.opacity(0.85))
                    .lineLimit(1)
            }
            .padding(14)
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

    private var gradient: LinearGradient {
        switch template.style {
        case .aurora:
            LinearGradient(colors: [LiquidTheme.primaryGlow.opacity(0.40), Color.purple.opacity(0.26), LiquidTheme.surface], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .sunset:
            LinearGradient(colors: [LiquidTheme.secondaryGlow.opacity(0.38), Color.orange.opacity(0.24), LiquidTheme.surface], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .emerald:
            LinearGradient(colors: [LiquidTheme.tertiaryGlow.opacity(0.38), Color.teal.opacity(0.24), LiquidTheme.surface], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
}

private struct NewTemplatePlaceholderView: View {
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
            Text("New")
                .font(.system(.caption2).weight(.bold))
                .tracking(2.4)
                .textCase(.uppercase)
                .foregroundStyle(LiquidTheme.primary.opacity(0.6))
        }
        .frame(maxWidth: .infinity)
        .aspectRatio(1.05, contentMode: .fit)
        .padding(14)
        .overlay {
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .strokeBorder(LiquidTheme.primary.opacity(0.22), style: StrokeStyle(lineWidth: 2, dash: [8, 8]))
        }
    }
}

#Preview {
    AddPageView()
}

