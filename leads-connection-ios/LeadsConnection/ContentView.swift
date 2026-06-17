import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appVM: AppViewModel

    var body: some View {
        if appVM.isLoggedIn {
            MainTabView()
                .transition(.opacity)
        } else {
            LoginView()
                .transition(.opacity)
        }
    }
}
