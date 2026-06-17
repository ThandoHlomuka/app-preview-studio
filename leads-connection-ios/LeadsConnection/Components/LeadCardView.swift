import SwiftUI

struct LeadCardView: View {
    let lead: Lead
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(lead.title)
                        .font(AppTheme.bodyFont(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(.themeTextPrimary)
                        .lineLimit(1)
                    Spacer()
                    if lead.isUrgent {
                        Text("URGENT")
                            .font(AppTheme.smallFont(size: 9))
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(Color.themeError)
                            .cornerRadius(4)
                    }
                }

                Text(lead.description)
                    .font(AppTheme.bodyFont(size: 13))
                    .foregroundColor(.themeTextSecondary)
                    .lineLimit(2)

                HStack(spacing: 16) {
                    HStack(spacing: 4) {
                        Image(systemName: "mappin.circle.fill")
                            .font(.caption)
                            .foregroundColor(.themeTextMuted)
                        Text(lead.location)
                            .font(AppTheme.captionFont(size: 11))
                            .foregroundColor(.themeTextMuted)
                    }
                    Spacer()
                    HStack(spacing: 4) {
                        Image(systemName: "tag.fill")
                            .font(.caption)
                            .foregroundColor(.themeSecondary)
                        Text(lead.budget, format: .currency(code: "ZAR"))
                            .font(AppTheme.captionFont(size: 12))
                            .foregroundColor(.themeSecondary)
                            .fontWeight(.bold)
                    }
                }

                HStack(spacing: 8) {
                    ChipView(text: lead.type, color: .themePrimaryLight)
                    ChipView(text: lead.category.replacingOccurrences(of: "_", with: " "), color: .themeSecondary)
                }
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.themeSurfaceGlass)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.themeBorder, lineWidth: 0.5)
                    )
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ChipView: View {
    let text: String
    let color: Color

    var body: some View {
        Text(text)
            .font(AppTheme.smallFont(size: 9))
            .foregroundColor(color)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(color.opacity(0.15))
            .cornerRadius(4)
    }
}
