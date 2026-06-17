import SwiftUI

struct TopBarView: View {
    let title: String
    var showBack: Bool = false
    var actionIcon: String? = nil
    var onBack: (() -> Void)? = nil
    var onAction: (() -> Void)? = nil

    var body: some View {
        HStack {
            if showBack {
                Button {
                    onBack?()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.themeTextPrimary)
                }
            } else {
                Spacer().frame(width: 44)
            }

            Spacer()

            Text(title)
                .font(AppTheme.bodyFont(size: 17))
                .fontWeight(.semibold)
                .foregroundColor(.themeTextPrimary)

            Spacer()

            if let icon = actionIcon {
                Button {
                    onAction?()
                } label: {
                    Image(systemName: icon)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.themeTextPrimary)
                }
            } else {
                Spacer().frame(width: 44)
            }
        }
        .padding(.horizontal, 16)
        .frame(height: AppTheme.topBarHeight)
        .background(
            Rectangle()
                .fill(Color.themeSurfaceGlass)
                .background(.ultraThinMaterial)
        )
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(Color.themeBorder)
                .frame(height: 0.5)
        }
    }
}
