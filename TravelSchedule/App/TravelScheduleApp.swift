import SwiftUI

@main
struct TravelScheduleApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = true
    
    private var choosingCityViewModel = ChoosingCityViewModel()
    private var stationSelectionViewModel = StationSelectionViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView(
                viewedStories: false,
                choosingCityViewModel: choosingCityViewModel,
                stationSelectionViewModel: stationSelectionViewModel
            )
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
