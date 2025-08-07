//
//  MainView.swift
//  TravelSchedule
//
//  Created by Kira on 01.07.2025.
//

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
                case .choosingCity(let station, let fromField):
                    ChoosingCityView(coordinator: coordinator, station: station, fromField: fromField)
                case .stationSelection(let city, let fromField):
                    StationSelectionView(coordinator: coordinator, city: city, fromField: fromField)
                case .ticketFiltering:
                    TicketFilteringView(coordinator: coordinator)
                case .routeParameter:
                    RouteParameterClarificationsView(coordinator: coordinator)
                case .flightSelection(let ticket):
                    FlightSelectionView(coordinator: coordinator, ticket: ticket)
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
    MainView( viewedStories: false)
}
