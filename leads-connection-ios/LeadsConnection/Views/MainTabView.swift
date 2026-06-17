import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var appVM: AppViewModel
    @State private var selectedTab: Int = 0

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                switch selectedTab {
                case 0:
                    HomeView()
                        .transition(.opacity)
                case 1:
                    LeadsListView()
                        .transition(.opacity)
                case 2:
                    ProfileView()
                        .transition(.opacity)
                default:
                    HomeView()
                        .transition(.opacity)
                }
            }

            BottomTabBar(selectedTab: $selectedTab)
        }
        .background(AppTheme.backgroundGradient.ignoresSafeArea())
    }
}
