import SwiftUI

enum LiquidTheme {
    static let surface = Color(red: 0x13 / 255, green: 0x13 / 255, blue: 0x15 / 255)
    static let onSurface = Color(red: 0xE5 / 255, green: 0xE1 / 255, blue: 0xE4 / 255)
    static let onSurfaceVariant = Color(red: 0xB9 / 255, green: 0xCA / 255, blue: 0xCB / 255)

    static let primary = Color(red: 0xDB / 255, green: 0xFC / 255, blue: 0xFF / 255)
    static let primaryGlow = Color(red: 0x00 / 255, green: 0xDB / 255, blue: 0xE9 / 255)
    static let secondaryGlow = Color(red: 0xFF / 255, green: 0x2F / 255, blue: 0xD6 / 255)
    static let tertiaryGlow = Color(red: 0x00 / 255, green: 0xF7 / 255, blue: 0xA6 / 255)
}

extension View {
    func liquidForeground() -> some View {
        foregroundStyle(LiquidTheme.onSurface)
    }
}

