import SwiftUI

struct AdOverlayView: View {
    let ad: AdCreative
    let onClose: () -> Void
    let onCtaTap: () -> Void

    @State private var countdown: Int = 4
    @State private var canDismiss: Bool = false
    @State private var scale: CGFloat = 0.8
    @State private var opacity: Double = 0

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                HStack {
                    Text("Sponsored ")
                        .font(AppTheme.captionFont(size: 11))
                        .foregroundColor(.themeTextMuted)
                    Image(systemName: "info.circle.fill")
                        .font(.caption)
                        .foregroundColor(.themeTextMuted)
                    Spacer()
                }

                ZStack {
                    Circle()
                        .fill(Color(hex: ad.color).opacity(0.2))
                        .frame(width: 72, height: 72)
                    Circle()
                        .fill(Color(hex: ad.color))
                        .frame(width: 52, height: 52)
                    Image(systemName: "person.2.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                }

                Text(ad.advertiser)
                    .font(AppTheme.headingFont(size: 20))
                    .foregroundColor(.themeTextPrimary)

                Text(ad.headline)
                    .font(AppTheme.bodyFont(size: 16))
                    .fontWeight(.semibold)
                    .foregroundColor(.themeTextPrimary)
                    .multilineTextAlignment(.center)

                Text(ad.body)
                    .font(AppTheme.bodyFont(size: 14))
                    .foregroundColor(.themeTextSecondary)
                    .multilineTextAlignment(.center)

                Text("Ad")
                    .font(AppTheme.smallFont(size: 8))
                    .foregroundColor(.themeTextMuted)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.themeBorder)
                    .cornerRadius(3)

                Button {
                    onCtaTap()
                } label: {
                    Text(ad.cta)
                        .font(AppTheme.bodyFont(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(Color(hex: ad.color))
                        .cornerRadius(12)
                }
                .padding(.horizontal, 16)

                if canDismiss {
                    Button {
                        onClose()
                    } label: {
                        Text("Skip ad")
                            .font(AppTheme.captionFont(size: 12))
                            .foregroundColor(.themeTextMuted)
                    }
                } else {
                    Text("Skip ad \(countdown)s")
                        .font(AppTheme.captionFont(size: 12))
                        .foregroundColor(.themeTextMuted)
                }
            }
            .padding(24)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.themeSurface)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.themeBorder, lineWidth: 0.5)
                    )
            )
            .padding(.horizontal, 32)
            .scaleEffect(scale)
            .opacity(opacity)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.3)) {
                scale = 1.0
                opacity = 1.0
            }
        }
        .onReceive(timer) { _ in
            if countdown > 0 {
                countdown -= 1
            }
            if countdown == 0 {
                canDismiss = true
            }
        }
    }
}
