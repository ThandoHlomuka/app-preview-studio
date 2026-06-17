import SwiftUI

struct LeadDetailView: View {
    @EnvironmentObject var appVM: AppViewModel
    @Environment(\.dismiss) var dismiss
    let lead: Lead
    @State private var showEdit = false
    @State private var showDeleteConfirmation = false

    var body: some View {
        VStack(spacing: 0) {
            TopBarView(
                title: "Lead Details",
                showBack: true,
                actionIcon: "pencil",
                onBack: { dismiss() },
                onAction: { showEdit = true }
            )

            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    headerSection
                    statusSection
                    budgetSection
                    descriptionSection
                    infoSection
                    contactSection
                    tagsSection
                    actionButtons
                }
                .padding(16)
            }
            .background(AppTheme.backgroundGradient.ignoresSafeArea())
        }
        .background(AppTheme.backgroundGradient.ignoresSafeArea())
        .navigationBarHidden(true)
        .fullScreenCover(isPresented: $appVM.showingAd) {
            if let ad = appVM.currentAd {
                AdOverlayView(ad: ad) {
                    appVM.showingAd = false
                    appVM.adDismissable = false
                } onCtaTap: {
                    appVM.showingAd = false
                    appVM.adDismissable = false
                }
            }
        }
        .onAppear {
            _ = appVM.recordLeadView()
        }
        .alert("Delete Lead", isPresented: $showDeleteConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                appVM.deleteLead(id: lead.id)
                dismiss()
            }
        } message: {
            Text("Are you sure you want to delete this lead? This action cannot be undone.")
        }
        .sheet(isPresented: $showEdit) {
            EditLeadView(lead: lead)
        }
    }

    private var headerSection: some View {
        HStack {
            Text(lead.title)
                .font(AppTheme.headingFont(size: 22))
                .foregroundColor(.themeTextPrimary)
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
    }

    private var statusSection: some View {
        HStack(spacing: 8) {
            StatusPill(text: lead.status, color: statusColor(lead.status))
            StatusPill(text: lead.priority, color: priorityColor(lead.priority))
            Spacer()
        }
    }

    private func statusColor(_ s: String) -> Color {
        switch s {
        case "Open": return .themeSuccess
        case "In Progress": return .themeWarning
        case "Completed": return .themeSecondary
        case "Closed": return .themeTextMuted
        default: return .themeTextMuted
        }
    }

    private func priorityColor(_ p: String) -> Color {
        switch p {
        case "Urgent": return .themeError
        case "High": return .themeWarning
        case "Medium": return .themeSecondary
        case "Low": return .themeTextMuted
        default: return .themeTextMuted
        }
    }

    private var budgetSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Budget")
                .font(AppTheme.captionFont(size: 11))
                .foregroundColor(.themeTextMuted)
                .textCase(.uppercase)
            Text(lead.budget, format: .currency(code: "ZAR"))
                .font(AppTheme.titleFont(size: 32))
                .foregroundColor(.themeSecondary)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.themeSurfaceGlass)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.themeBorder, lineWidth: 0.5)
                )
        )
    }

    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Description")
                .font(AppTheme.headingFont(size: 16))
                .foregroundColor(.themeTextPrimary)
            Text(lead.description)
                .font(AppTheme.bodyFont(size: 14))
                .foregroundColor(.themeTextSecondary)
                .lineSpacing(4)
        }
    }

    private var infoSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Lead Information")
                .font(AppTheme.headingFont(size: 16))
                .foregroundColor(.themeTextPrimary)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                InfoRow(label: "Type", value: lead.type)
                InfoRow(label: "Category", value: lead.category.replacingOccurrences(of: "_", with: " "))
                InfoRow(label: "Location", value: "\(lead.location), \(lead.province)")
                InfoRow(label: "Province", value: lead.province)
                InfoRow(label: "Company", value: lead.company)
                InfoRow(label: "Posted", value: appVM.formatDate(lead.createdAt))
                InfoRow(label: "Views", value: "\(lead.views)")
                InfoRow(label: "Applications", value: "\(lead.applications)")
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

    private var contactSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Contact")
                .font(AppTheme.headingFont(size: 16))
                .foregroundColor(.themeTextPrimary)
            HStack(spacing: 12) {
                Image(systemName: "envelope.fill")
                    .foregroundColor(.themeSecondary)
                    .frame(width: 20)
                Text(lead.contactEmail)
                    .font(AppTheme.bodyFont(size: 14))
                    .foregroundColor(.themeTextPrimary)
                Spacer()
            }
            HStack(spacing: 12) {
                Image(systemName: "phone.fill")
                    .foregroundColor(.themeSecondary)
                    .frame(width: 20)
                Text(lead.contactPhone)
                    .font(AppTheme.bodyFont(size: 14))
                    .foregroundColor(.themeTextPrimary)
                Spacer()
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

    private var tagsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Tags")
                .font(AppTheme.headingFont(size: 16))
                .foregroundColor(.themeTextPrimary)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 6) {
                ForEach(lead.tags, id: \.self) { tag in
                    Text("#\(tag)")
                        .font(AppTheme.smallFont(size: 10))
                        .foregroundColor(.themePrimaryLight)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color.themePrimaryLight.opacity(0.12))
                        .cornerRadius(6)
                }
            }
        }
    }

    private var actionButtons: some View {
        HStack(spacing: 12) {
            if appVM.isLeadSaved(lead.id) {
                Button {
                    appVM.unsaveLead(lead.id)
                } label: {
                    Label("Saved", systemImage: "bookmark.fill")
                        .font(AppTheme.captionFont(size: 13))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(Color.themeSuccess)
                        .cornerRadius(10)
                }
            } else {
                Button {
                    appVM.saveLead(lead.id)
                } label: {
                    Label("Save", systemImage: "bookmark")
                        .font(AppTheme.captionFont(size: 13))
                        .foregroundColor(.themePrimaryLight)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.themePrimaryLight, lineWidth: 1)
                        )
                }
            }

            if appVM.hasApplied(lead.id) {
                Button {
                } label: {
                    Label("Applied", systemImage: "checkmark.circle.fill")
                        .font(AppTheme.captionFont(size: 13))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(Color.themeSuccess)
                        .cornerRadius(10)
                }
                .disabled(true)
            } else {
                Button {
                    appVM.applyToLead(lead.id)
                } label: {
                    Label("Apply", systemImage: "paperplane.fill")
                        .font(AppTheme.captionFont(size: 13))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(AppTheme.primaryGradient)
                        .cornerRadius(10)
                }
            }
        }

        Button {
            showDeleteConfirmation = true
        } label: {
            Label("Delete Lead", systemImage: "trash")
                .font(AppTheme.captionFont(size: 13))
                .foregroundColor(.themeError)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.themeError, lineWidth: 1)
                )
        }
    }
}

struct StatusPill: View {
    let text: String
    let color: Color

    var body: some View {
        Text(text)
            .font(AppTheme.smallFont(size: 10))
            .foregroundColor(color)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(color.opacity(0.15))
            .cornerRadius(6)
    }
}

struct InfoRow: View {
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label)
                .font(AppTheme.smallFont(size: 9))
                .foregroundColor(.themeTextMuted)
                .textCase(.uppercase)
            Text(value)
                .font(AppTheme.bodyFont(size: 13))
                .foregroundColor(.themeTextPrimary)
                .lineLimit(1)
        }
    }
}
