//
//  RouteEnum.swift
//  TravelSchedule
//
//  Created by Kira on 21.07.2025.
//

import Foundation

enum RouteEnum: Hashable {
    case choosingCity(station: String, fromField: Bool)
    case stationSelection(city: String, fromField: Bool)
    case ticketFiltering
    case routeParameter
    case flightSelection(Ticket)
}
