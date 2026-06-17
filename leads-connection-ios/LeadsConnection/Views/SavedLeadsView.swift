import SwiftUI

struct SavedLeadsView: View {
    @EnvironmentObject var appVM: AppViewModel
    @Environment(\.dismiss) var dismiss

    private var savedLeads: [Lead] {
        appVM.getSavedLeads()
    }

    var body: some View {
        VStack(spacing: 0) {
            TopBarView(
                title: "Saved Leads (\(savedLeads.count))",
                showBack: true,
                onBack: { dismiss() }
            )

            if savedLeads.isEmpty {
                Spacer()
                VStack(spacing: 12) {
                    Image(systemName: "bookmark.slash")
                        .font(.system(size: 48))
                        .foregroundColor(.themeTextMuted)
                    Text("No saved leads")
                        .font(AppTheme.headingFont(size: 18))
                        .foregroundColor(.themeTextSecondary)
                    Text("Tap the bookmark icon on a lead to save it")
                        .font(AppTheme.bodyFont(size: 13))
                        .foregroundColor(.themeTextMuted)
                }
                Spacer()
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 12) {
                        ForEach(savedLeads) { lead in
                            LeadCardView(lead: lead) {
                                appVM.navigationPath.append(lead.id)
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
