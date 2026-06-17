import SwiftUI

struct TabItem: Identifiable {
    let id = UUID()
    let icon: String
    let label: String
}

let tabItems = [
    TabItem(icon: "house.fill", label: "Home"),
    TabItem(icon: "globe", label: "Leads"),
    TabItem(icon: "person.fill", label: "Profile")
]

struct BottomTabBar: View {
    @Binding var selectedTab: Int

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(tabItems.enumerated()), id: \.element.id) { index, item in
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selectedTab = index
                    }
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: item.icon)
                            .font(.system(size: 20, weight: selectedTab == index ? .semibold : .regular))
                        Text(item.label)
                            .font(AppTheme.smallFont(size: 9))
                    }
                    .foregroundColor(selectedTab == index ? .themePrimaryLight : .themeTextMuted)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                }
            }
        }
        .padding(.horizontal, 8)
        .padding(.bottom, 8)
        .background(
            Rectangle()
                .fill(Color.themeSurfaceGlass)
                .background(.ultraThinMaterial)
        )
        .overlay(alignment: .top) {
            Rectangle()
                .fill(Color.themeBorder)
                .frame(height: 0.5)
        }
    }
}
