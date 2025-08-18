import Foundation

enum RouteEnum: Hashable {
    /// TODO
    case choosingCity(searchText: String, station: String, fromField: Bool)
    case stationSelection(searchText: String, city: String, fromField: Bool)
    case ticketFiltering
    case routeParameter
    case flightSelection(Ticket)
}
