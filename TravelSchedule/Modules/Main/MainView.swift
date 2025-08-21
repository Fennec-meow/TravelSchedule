import SwiftUI

// MARK: - MainView

struct MainView: View {
    
    // MARK: Public Property
    
    @EnvironmentObject var services: APIServicesContainer
    
    @StateObject var coordinator = NavCoordinator()
    @State var viewedStories: Bool // TODO: заинитить storiesViewModel и брать значение оттуда
    
    @ObservedObject private var choosingCityViewModel: ChoosingCityViewModel
    @ObservedObject private var stationSelectionViewModel: StationSelectionViewModel
    @ObservedObject private var ticketFilteringViewModel: TicketFilteringViewModel
    @ObservedObject private var flightSelectionViewModel: FlightSelectionViewModel
    
    init(
        viewedStories: Bool,
        choosingCityViewModel: ChoosingCityViewModel,
        stationSelectionViewModel: StationSelectionViewModel,
        ticketFilteringViewModel: TicketFilteringViewModel,
        flightSelectionViewModel: FlightSelectionViewModel
    ) {
        self.viewedStories = viewedStories
        self.choosingCityViewModel = choosingCityViewModel
        self.stationSelectionViewModel = stationSelectionViewModel
        self.ticketFilteringViewModel = ticketFilteringViewModel
        self.flightSelectionViewModel = flightSelectionViewModel
    }
    
    // MARK: body
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            TabView {
                CitySelectionScreen(
                    coordinator: coordinator,
                    choosingCityViewModel: choosingCityViewModel
                )
                .task {
                    
                }
                .tabItem {
                    Image(.schedule)
                        .renderingMode(.template)
                }
                SettingsView()
                    .tabItem {
                        Image(.settings)
                            .renderingMode(.template)
                    }
            }
            .tint(.blackForTheme)
            .navigationDestination(for: Route.self) { route in
                switch route {
                    /// TODO
                case .choosingCity(let searchText, let station, let direction, let cities):
                    ChoosingCityView(
                        viewModel: choosingCityViewModel,
                        coordinator: coordinator
                    )
                    .onAppear {
                        choosingCityViewModel.searchText = searchText
                        choosingCityViewModel.station = station
                        choosingCityViewModel.direction = direction
                    }
                case .stationSelection(let searchText, let city, let direction, let stations):
                    StationSelectionView(
                        viewModel: stationSelectionViewModel,
                        coordinator: coordinator
                    )
                    .onAppear {
                        stationSelectionViewModel.searchText = searchText
                        stationSelectionViewModel.city = city
                        stationSelectionViewModel.direction = direction
                        stationSelectionViewModel.stations = stations
                    }
                case .ticketFiltering:
                    TicketFilteringView(
                        viewModel: ticketFilteringViewModel,
                        coordinator: coordinator
                    )
                case .routeParameter:
                    RouteParameterClarificationsView(
                        coordinator: coordinator
                    )
                case .flightSelection(let ticket):
                    FlightSelectionView(
                        coordinator: coordinator,
                        viewModel: flightSelectionViewModel
                    )
                    .onAppear {
                        flightSelectionViewModel.ticket = ticket
                    }
                }
            }
        }
        .onChange(of: coordinator.path) {
            if coordinator.path.isEmpty {
                coordinator.timeFilters.removeAll()
                coordinator.showTransfers = nil
            }
        }
    }
}
