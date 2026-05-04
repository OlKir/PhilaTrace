import SwiftUI

enum LiquidTheme {
    static let surface = Color(red: 19 / 255, green: 19 / 255, blue: 21 / 255)
    static let onSurface = Color(red: 229 / 255, green: 225 / 255, blue: 228 / 255)
    static let onSurfaceVariant = Color(red: 185 / 255, green: 202 / 255, blue: 203 / 255)

    static let primary = Color(red: 219 / 255, green: 252 / 255, blue: 255 / 255)
    static let primaryGlow = Color(red: 0 / 255, green: 219 / 255, blue: 233 / 255)
    static let secondaryGlow = Color(red: 255 / 255, green: 47 / 255, blue: 214 / 255)
    static let tertiaryGlow = Color(red: 0 / 255, green: 247 / 255, blue: 166 / 255)
}

extension View {
    func liquidForeground() -> some View {
        foregroundStyle(LiquidTheme.onSurface)
    }
}
