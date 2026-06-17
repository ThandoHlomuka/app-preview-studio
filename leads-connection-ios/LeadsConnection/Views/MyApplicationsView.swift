import SwiftUI

struct MyApplicationsView: View {
    @EnvironmentObject var appVM: AppViewModel
    @Environment(\.dismiss) var dismiss

    private var applications: [LeadApplication] {
        appVM.getMyApplications()
    }

    private func leadForApplication(_ app: LeadApplication) -> Lead? {
        appVM.leads.first { $0.id == app.leadId }
    }

    var body: some View {
        VStack(spacing: 0) {
            TopBarView(
                title: "My Applications (\(applications.count))",
                showBack: true,
                onBack: { dismiss() }
            )

            if applications.isEmpty {
                Spacer()
                VStack(spacing: 12) {
                    Image(systemName: "doc.text.magnifyingglass")
                        .font(.system(size: 48))
                        .foregroundColor(.themeTextMuted)
                    Text("No applications yet")
                        .font(AppTheme.headingFont(size: 18))
                        .foregroundColor(.themeTextSecondary)
                    Text("Apply to leads to see them here")
                        .font(AppTheme.bodyFont(size: 13))
                        .foregroundColor(.themeTextMuted)
                }
                Spacer()
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 12) {
                        ForEach(applications) { application in
                            if let lead = leadForApplication(application) {
                                ApplicationCardView(application: application, lead: lead)
                            }
                        }
                    }
                    .padding(16)
                }
            }
        }
        .background(AppTheme.backgroundGradient.ignoresSafeArea())
        .navigationBarHidden(true)
    }
}

struct ApplicationCardView: View {
    let application: LeadApplication
    let lead: Lead

    private var dateFormatted: String {
        let df = DateFormatter()
        df.dateFormat = "dd MMM yyyy"
        return df.string(from: application.appliedAt)
    }

    private var statusColor: Color {
        switch application.status {
        case "PENDING": return .themeWarning
        case "ACCEPTED": return .themeSuccess
        case "REJECTED": return .themeError
        default: return .themeTextMuted
        }
    }

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(lead.title)
                    .font(AppTheme.bodyFont(size: 15))
                    .fontWeight(.semibold)
                    .foregroundColor(.themeTextPrimary)
                    .lineLimit(1)
                Text("Applied \(dateFormatted)")
                    .font(AppTheme.captionFont(size: 11))
                    .foregroundColor(.themeTextMuted)
                HStack(spacing: 6) {
                    Text(lead.budget, format: .currency(code: "ZAR"))
                        .font(AppTheme.captionFont(size: 12))
                        .foregroundColor(.themeSecondary)
                        .fontWeight(.bold)
                    Text(lead.location)
                        .font(AppTheme.captionFont(size: 11))
                        .foregroundColor(.themeTextMuted)
                }
            }

            Spacer()

            Text(application.status)
                .font(AppTheme.smallFont(size: 9))
                .foregroundColor(statusColor)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(statusColor.opacity(0.15))
                .cornerRadius(4)
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
}
