import SwiftUI

struct GlossyTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(
                LinearGradient(
                    colors: [
                        .white.opacity(0.95),
                        LiquidTheme.onSurfaceVariant.opacity(0.9),
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
    }
}

extension View {
    func glossyText() -> some View { modifier(GlossyTextStyle()) }
}

