import Foundation

enum RouteEnum: Hashable {
    case choosingCity(station: String, fromField: Bool)
    case stationSelection(searchText: String, city: String, fromField: Bool)
    case ticketFiltering
    case routeParameter
    case flightSelection(Ticket)
}
