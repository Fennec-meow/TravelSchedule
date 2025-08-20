import SwiftUI

@main
struct TravelScheduleApp: App {

    @AppStorage("isDarkMode") private var isDarkMode = true
    
    private static var servicesInstance: APIServicesContainer = {
            do {
                return try APIServicesContainer()
            } catch {
                fatalError("Failed to initialize APIServicesContainer: \(error)")
            }
        }()

        @StateObject private var services = servicesInstance
    
    private var choosingCityViewModel = ChoosingCityViewModel(service: servicesInstance.allStationsService)
    private var stationSelectionViewModel = StationSelectionViewModel()
   
    
    var body: some Scene {
        WindowGroup {
//            TestFetch()
            MainView(
                viewedStories: false,
                choosingCityViewModel: choosingCityViewModel,
                stationSelectionViewModel: stationSelectionViewModel
            )
            .environmentObject(services)
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
