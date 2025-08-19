import SwiftUI

// MARK: - MainView

struct MainView: View {
    
    // MARK: Public Property
    
    @StateObject var coordinator = NavCoordinator()
    @State var viewedStories: Bool // TODO: заинитить storiesViewModel и брать значение оттуда
    
    @ObservedObject private var choosingCityViewModel: ChoosingCityViewModel
    @ObservedObject private var stationSelectionViewModel: StationSelectionViewModel
    
    init(
        viewedStories: Bool,
        choosingCityViewModel: ChoosingCityViewModel,
        stationSelectionViewModel: StationSelectionViewModel
    ) {
        self.viewedStories = viewedStories
        self.choosingCityViewModel = choosingCityViewModel
        self.stationSelectionViewModel = stationSelectionViewModel
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
                        choosingCityViewModel.cities = cities
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
                        coordinator: coordinator
                    )
                case .routeParameter:
                    RouteParameterClarificationsView(
                        coordinator: coordinator
                    )
                case .flightSelection(let ticket):
                    // TODO: по аналогии с другими viewModel выше (stationSelectionViewModel и choosingCityViewModel)
                    FlightSelectionView(
                        coordinator: coordinator,
                        viewModel: FlightSelectionViewModel(
                            ticket: ticket
                        ))
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

#Preview {
    MainView(
        viewedStories: false,
        choosingCityViewModel: ChoosingCityViewModel(),
        stationSelectionViewModel: StationSelectionViewModel()
    )
}
