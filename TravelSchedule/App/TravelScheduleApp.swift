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
    private var ticketFilteringViewModel = TicketFilteringViewModel(schedualBetweenStationsService: servicesInstance.schedualBetweenStationsService)
    private var flightSelectionViewModel = FlightSelectionViewModel(carrierInfoService: servicesInstance.carrierInfoService)
    
    
    var body: some Scene {
        WindowGroup {
            //            TestFetch()
            MainView(
                viewedStories: false,
                choosingCityViewModel: choosingCityViewModel,
                stationSelectionViewModel: stationSelectionViewModel,
                ticketFilteringViewModel: ticketFilteringViewModel,
                flightSelectionViewModel: flightSelectionViewModel
            )
            .environmentObject(services)
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
