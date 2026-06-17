import SwiftUI

@main
struct LeadsConnectionApp: App {
    @StateObject private var appVM = AppViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appVM)
                .preferredColorScheme(.dark)
                .background(AppTheme.backgroundGradient.ignoresSafeArea())
        }
    }
}
