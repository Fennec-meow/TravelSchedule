import SwiftUI

@main
struct TravelScheduleApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = true
    
    var body: some Scene {
        WindowGroup {
            MainView(viewedStories: false)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
