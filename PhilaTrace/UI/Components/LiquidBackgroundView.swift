import SwiftUI

struct LiquidBackgroundView: View {
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size

            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0x1A / 255, green: 0x0B / 255, blue: 0x2E / 255),
                        LiquidTheme.surface,
                        Color(red: 0x00 / 255, green: 0x20 / 255, blue: 0x22 / 255),
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                LiquidBlob(
                    color: LiquidTheme.primaryGlow.opacity(0.35),
                    size: 420,
                    position: CGPoint(x: 70, y: 80)
                )

                LiquidBlob(
                    color: LiquidTheme.secondaryGlow.opacity(0.25),
                    size: 320,
                    position: CGPoint(x: size.width - 60, y: size.height - 220)
                )
            }
        }
    }
}

private struct LiquidBlob: View {
    let color: Color
    let size: CGFloat
    let position: CGPoint

    var body: some View {
        Circle()
            .fill(color)
            .frame(width: size, height: size)
            .blur(radius: 80)
            .position(position)
            .allowsHitTesting(false)
    }
}

#Preview {
    LiquidBackgroundView()
}
