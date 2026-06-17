import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b, a: UInt64
        switch hex.count {
        case 3:
            (r, g, b, a) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17, 255)
        case 6:
            (r, g, b, a) = (int >> 16, int >> 8 & 0xFF, int & 0xFF, 255)
        case 8:
            (r, g, b, a) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b, a) = (0, 0, 0, 255)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }

    static let themeBackground = Color(hex: "0A0A0F")
    static let themeSurface = Color(hex: "14141F")
    static let themeSurfaceAlt = Color(hex: "1A1025")
    static let themePrimary = Color(hex: "7C3AED")
    static let themePrimaryLight = Color(hex: "A855F7")
    static let themeSecondary = Color(hex: "06B6D4")
    static let themeSurfaceGlass = Color.white.opacity(0.04)
    static let themeTextPrimary = Color.white
    static let themeTextSecondary = Color.white.opacity(0.6)
    static let themeTextMuted = Color.white.opacity(0.35)
    static let themeSuccess = Color(hex: "10B981")
    static let themeWarning = Color(hex: "F59E0B")
    static let themeError = Color(hex: "EF4444")
    static let themeBorder = Color.white.opacity(0.08)
}

struct AppTheme {
    static let navBarHeight: CGFloat = 56
    static let topBarHeight: CGFloat = 48

    static func titleFont(size: CGFloat = 28) -> Font {
        .system(size: size, weight: .bold)
    }

    static func headingFont(size: CGFloat = 20) -> Font {
        .system(size: size, weight: .semibold)
    }

    static func bodyFont(size: CGFloat = 15) -> Font {
        .system(size: size, weight: .regular)
    }

    static func captionFont(size: CGFloat = 12) -> Font {
        .system(size: size, weight: .medium)
    }

    static func smallFont(size: CGFloat = 10) -> Font {
        .system(size: size, weight: .bold)
    }

    static let primaryGradient = LinearGradient(
        colors: [Color(hex: "7C3AED"), Color(hex: "A855F7")],
        startPoint: .leading,
        endPoint: .trailing
    )

    static let backgroundGradient = LinearGradient(
        colors: [Color(hex: "0A0A0F"), Color(hex: "14141F"), Color(hex: "1A1025")],
        startPoint: .top,
        endPoint: .bottom
    )

    static let glassBackground: some View = Color.themeSurfaceGlass
        .background(.ultraThinMaterial)
        .cornerRadius(12)

    static func glassCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        content()
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.themeSurfaceGlass)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.themeBorder, lineWidth: 0.5)
                    )
            )
            .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
    }
}
