import SwiftUI

// MARK: - MainView

struct MainView: View {
    
    // MARK: Public Property
    
    @StateObject var coordinator = NavCoordinator()
    @State  var viewedStories: Bool
    
    // MARK: body
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            TabView {
                CitySelectionScreen(coordinator: coordinator, viewedStories: viewedStories)
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
            .navigationDestination(for: RouteEnum.self) { route in
                switch route {
                    /// TODO
                case .choosingCity(let searchText, let station, let fromField):
                    ChoosingCityView(
                        viewModel: ChoosingCityViewModel(
                            searchText: searchText,
                            station: station,
                            fromField: fromField,
                        ),
                        coordinator: coordinator
                    )
                case .stationSelection(let searchText, let city, let fromField):
                    StationSelectionView(
                        viewModel: StationSelectionViewModel(
                            searchText: searchText,
                            city: city,
                            fromField: fromField
                        ),
                        coordinator: coordinator
                    )
                case .ticketFiltering:
                    TicketFilteringView(
                        coordinator: coordinator
                    )
                case .routeParameter:
                    RouteParameterClarificationsView(
                        coordinator: coordinator
                    )
                case .flightSelection(let ticket):
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
    MainView(viewedStories: false)
}
