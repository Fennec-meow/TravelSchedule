import Foundation

enum Route: Hashable {
    /// TODO
    case choosingCity(
        searchText: String,
        station: String,
        direction: GoingDirection,
        cities: [String]
    )
    case stationSelection(
        searchText: String,
        city: String,
        direction: GoingDirection,
        stations: [String]
    )
    case ticketFiltering
    case routeParameter
    case flightSelection(Ticket)
}

// TODO: вынести в отдельный файл
enum GoingDirection {
    case from
    case `where`
}
