import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appVM: AppViewModel

    var body: some View {
        NavigationStack(path: $appVM.navigationPath) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    welcomeCard
                    statsRow
                    quickActions
                    recentLeadsSection
                    footerLinks
                }
                .padding(16)
            }
            .background(AppTheme.backgroundGradient.ignoresSafeArea())
            .navigationDestination(for: String.self) { destination in
                switch destination {
                case "leads":
                    LeadsListView()
                case "postLead":
                    PostLeadView()
                case "profile":
                    ProfileView()
                default:
                    if let lead = appVM.leads.first(where: { $0.id == destination }) {
                        LeadDetailView(lead: lead)
                    }
                }
            }
        }
    }

    private var welcomeCard: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Welcome back, \(appVM.currentUser?.firstName ?? "User")!")
                .font(AppTheme.headingFont(size: 22))
                .foregroundColor(.themeTextPrimary)
            Text("Here's what's happening with your leads")
                .font(AppTheme.bodyFont(size: 13))
                .foregroundColor(.themeTextSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.themeSurfaceGlass)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(AppTheme.primaryGradient, lineWidth: 1)
                )
        )
    }

    private var statsRow: some View {
        HStack(spacing: 12) {
            StatCardView(
                value: "\(appVM.currentUser?.stats.newLeads ?? 0)",
                label: "New Leads",
                color: .themeSecondary
            )
            StatCardView(
                value: "\(appVM.currentUser?.stats.completed ?? 0)",
                label: "Completed",
                color: .themeSuccess
            )
            StatCardView(
                value: "\(appVM.currentUser?.stats.inProgress ?? 0)",
                label: "In Progress",
                color: .themeWarning
            )
        }
    }

    private var quickActions: some View {
        HStack(spacing: 12) {
            Button {
                appVM.navigationPath.append("leads")
            } label: {
                HStack {
                    Image(systemName: "magnifyingglass")
                    Text("Browse Leads")
                }
                .font(AppTheme.captionFont(size: 13))
                .foregroundColor(.themePrimaryLight)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.themePrimaryLight, lineWidth: 1)
                )
            }

            Button {
                appVM.navigationPath.append("postLead")
            } label: {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Post a Lead")
                }
                .font(AppTheme.captionFont(size: 13))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .background(AppTheme.primaryGradient)
                .cornerRadius(10)
            }
        }
    }

    private var recentLeadsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recent Leads")
                .font(AppTheme.headingFont(size: 18))
                .foregroundColor(.themeTextPrimary)

            ForEach(Array(appVM.leads.prefix(5))) { lead in
                LeadCardView(lead: lead) {
                    appVM.navigationPath.append(lead.id)
                }
            }
        }
    }

    private var footerLinks: some View {
        HStack(spacing: 24) {
            Button {
                appVM.navigationPath.append("savedLeads")
            } label: {
                HStack(spacing: 4) {
                    Image(systemName: "bookmark.fill")
                        .font(.caption)
                    Text("\(appVM.savedLeadIds.count) Saved")
                        .font(AppTheme.captionFont(size: 12))
                }
                .foregroundColor(.themeTextSecondary)
            }

            Button {
                appVM.navigationPath.append("myApplications")
            } label: {
                HStack(spacing: 4) {
                    Image(systemName: "doc.text.fill")
                        .font(.caption)
                    Text("\(appVM.applications.count) Applications")
                        .font(AppTheme.captionFont(size: 12))
                }
                .foregroundColor(.themeTextSecondary)
            }
        }
        .padding(.top, 8)
    }
}
