import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appVM: AppViewModel
    @State private var showEditProfile = false
    @State private var showSavedLeads = false
    @State private var showMyApplications = false
    @State private var showLogoutAlert = false

    var body: some View {
        NavigationStack(path: $appVM.navigationPath) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    profileHeader
                    statsRow

                    VStack(alignment: .leading, spacing: 0) {
                        Text("Settings")
                            .font(AppTheme.headingFont(size: 18))
                            .foregroundColor(.themeTextPrimary)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 8)

                        settingsList
                    }
                }
                .padding(.vertical, 16)
            }
            .background(AppTheme.backgroundGradient.ignoresSafeArea())
            .navigationDestination(for: String.self) { destination in
                switch destination {
                case "editProfile":
                    EditProfileView()
                case "savedLeads":
                    SavedLeadsView()
                case "myApplications":
                    MyApplicationsView()
                case "editLead":
                    if let lead = appVM.leads.first {
                        EditLeadView(lead: lead)
                    }
                default:
                    EmptyView()
                }
            }
            .sheet(isPresented: $showEditProfile) {
                EditProfileView()
            }
            .sheet(isPresented: $showSavedLeads) {
                SavedLeadsView()
            }
            .sheet(isPresented: $showMyApplications) {
                MyApplicationsView()
            }
            .alert("Logout", isPresented: $showLogoutAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Logout", role: .destructive) {
                    appVM.logout()
                }
            } message: {
                Text("Are you sure you want to logout?")
            }
        }
    }

    private var profileHeader: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(AppTheme.primaryGradient)
                    .frame(width: 72, height: 72)
                Image(systemName: "person.fill")
                    .font(.system(size: 32))
                    .foregroundColor(.white)
            }

            VStack(spacing: 4) {
                Text("\(appVM.currentUser?.firstName ?? "") \(appVM.currentUser?.lastName ?? "")")
                    .font(AppTheme.headingFont(size: 20))
                    .foregroundColor(.themeTextPrimary)
                Text(appVM.currentUser?.email ?? "")
                    .font(AppTheme.bodyFont(size: 13))
                    .foregroundColor(.themeTextSecondary)
            }

            Text(appVM.currentUser?.type ?? "Service Provider")
                .font(AppTheme.smallFont(size: 10))
                .foregroundColor(.themeSuccess)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .background(Color.themeSuccess.opacity(0.15))
                .cornerRadius(6)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
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
        .padding(.horizontal, 16)
    }

    private var settingsList: some View {
        VStack(spacing: 0) {
            SettingsRow(icon: "person.text.rectangle.fill", label: "Edit Profile")
                .onTapGesture { showEditProfile = true }
            SettingsRow(icon: "bookmark.fill", label: "Saved Leads", count: appVM.savedLeadIds.count)
                .onTapGesture { showSavedLeads = true }
            SettingsRow(icon: "doc.text.fill", label: "My Applications", count: appVM.applications.count)
                .onTapGesture { showMyApplications = true }
            SettingsRow(icon: "bell.fill", label: "Notification Preferences")
            SettingsRow(icon: "gearshape.fill", label: "Service Categories")
            SettingsRow(icon: "map.fill", label: "Service Areas")
            SettingsRow(icon: "lock.fill", label: "Privacy & Security")
            SettingsRow(icon: "questionmark.circle.fill", label: "Help & Support")

            Button {
                showLogoutAlert = true
            } label: {
                HStack {
                    Image(systemName: "arrow.right.square.fill")
                        .foregroundColor(.themeError)
                        .frame(width: 24)
                    Text("Logout")
                        .font(AppTheme.bodyFont(size: 15))
                        .foregroundColor(.themeError)
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .background(Color.themeSurfaceGlass)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.themeSurfaceGlass)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.themeBorder, lineWidth: 0.5)
                )
        )
        .padding(.horizontal, 16)
    }
}

struct SettingsRow: View {
    let icon: String
    let label: String
    var count: Int? = nil

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.themePrimaryLight)
                .frame(width: 24)
            Text(label)
                .font(AppTheme.bodyFont(size: 15))
                .foregroundColor(.themeTextPrimary)
            Spacer()
            if let count = count {
                Text("\(count)")
                    .font(AppTheme.captionFont(size: 12))
                    .foregroundColor(.themeTextMuted)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(Color.themeBorder)
                    .cornerRadius(8)
            }
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.themeTextMuted)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(Color.themeSurfaceGlass)
    }
}
