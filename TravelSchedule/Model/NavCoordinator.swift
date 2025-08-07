//
//  NavCoordinator.swift
//  TravelSchedule
//
//  Created by Kira on 15.07.2025.
//

import SwiftUI

// MARK: - NavCoordinator

final class NavCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    @Published var selectedCityFrom: String = ""
    @Published var selectedStationFrom: String = ""
    @Published var selectedCityTo: String = ""
    @Published var selectedStationTo: String = ""
    @Published var timeFilters: Set<DepartureTime> = []
    @Published var showTransfers: Bool? = nil
    
    var isFiltersValid: Bool {
        !timeFilters.isEmpty && showTransfers != nil
    }
}
