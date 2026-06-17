import SwiftUI

struct LeadsListView: View {
    @EnvironmentObject var appVM: AppViewModel

    private var filteredLeads: [Lead] {
        var result = appVM.leads
        if let cat = appVM.selectedCategory, cat != "All" {
            result = result.filter { $0.category == cat }
        }
        if !appVM.searchQuery.isEmpty {
            result = result.filter {
                $0.title.localizedCaseInsensitiveContains(appVM.searchQuery) ||
                $0.description.localizedCaseInsensitiveContains(appVM.searchQuery) ||
                $0.location.localizedCaseInsensitiveContains(appVM.searchQuery) ||
                $0.company.localizedCaseInsensitiveContains(appVM.searchQuery)
            }
        }
        return result
    }

    var body: some View {
        VStack(spacing: 0) {
            TopBarView(title: "Browse Leads")

            VStack(spacing: 12) {
                searchBar
                categoryFilters
                resultsCount
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)

            if filteredLeads.isEmpty {
                Spacer()
                emptyState
                Spacer()
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 12) {
                        ForEach(filteredLeads) { lead in
                            NavigationLink(value: lead.id) {
                                LeadCardView(lead: lead) { }
                            }
                        }
                    }
                    .padding(16)
                }
            }
        }
        .background(AppTheme.backgroundGradient.ignoresSafeArea())
        .navigationDestination(for: String.self) { id in
            if let lead = appVM.leads.first(where: { $0.id == id }) {
                LeadDetailView(lead: lead)
            }
        }
    }

    private var searchBar: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.themeTextMuted)
                .font(.system(size: 16))
            TextField("Search leads...", text: $appVM.searchQuery)
                .font(AppTheme.bodyFont(size: 14))
                .foregroundColor(.themeTextPrimary)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            if !appVM.searchQuery.isEmpty {
                Button {
                    appVM.searchQuery = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.themeTextMuted)
                }
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.themeSurfaceGlass)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.themeBorder, lineWidth: 0.5)
                )
        )
    }

    private var categoryFilters: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(LeadCategory.allCases, id: \.rawValue) { category in
                    Button {
                        withAnimation {
                            appVM.selectedCategory = category == .all ? nil : category.rawValue
                        }
                    } label: {
                        Text(category.rawValue.replacingOccurrences(of: "_", with: " "))
                            .font(AppTheme.smallFont(size: 10))
                            .foregroundColor(
                                (category == .all && appVM.selectedCategory == nil) ||
                                category.rawValue == appVM.selectedCategory
                                ? .white : .themeTextSecondary
                            )
                            .padding(.horizontal, 14)
                            .padding(.vertical, 7)
                            .background(
                                (category == .all && appVM.selectedCategory == nil) ||
                                category.rawValue == appVM.selectedCategory
                                ? Color.themePrimary : Color.themeSurfaceGlass
                            )
                            .cornerRadius(16)
                    }
                }
            }
            .padding(.vertical, 4)
        }
    }

    private var resultsCount: some View {
        HStack {
            Text("\(filteredLeads.count) leads found")
                .font(AppTheme.captionFont(size: 12))
                .foregroundColor(.themeTextMuted)
            Spacer()
        }
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "tray")
                .font(.system(size: 48))
                .foregroundColor(.themeTextMuted)
            Text("No leads found")
                .font(AppTheme.headingFont(size: 18))
                .foregroundColor(.themeTextSecondary)
            Text("Try adjusting your search or filters")
                .font(AppTheme.bodyFont(size: 13))
                .foregroundColor(.themeTextMuted)
        }
    }
}
