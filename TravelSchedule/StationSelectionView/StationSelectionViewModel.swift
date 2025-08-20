import SwiftUI
/// TODO
@MainActor
final class StationSelectionViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published var city: String = ""
    @Published var direction: GoingDirection = .where
    @Published var stations: [String] = [
        "Киевский вокзал",
        "Курский вокзал",
        "Ярославский вокзал",
        "Белорусский вокзал",
        "Савеловский вокзал",
        "Ленинградский вокзал"
    ]
    
//    private var stationScheduleService: StationScheduleServiceProtocol
    
    var filteredItems: [String] {
        guard !searchText.isEmpty else { return stations }
        return stations.filter {
            $0.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    convenience init(
        searchText: String,
        city: String,
        direction: GoingDirection,
        stations: [String]
//        stationScheduleService: StationScheduleServiceProtocol
    ) {
        self.init()
        self.searchText = searchText
        self.city = city
        self.direction = direction
        self.stations = stations
//        self.stationScheduleService = stationScheduleService
    }
}

extension StationSelectionViewModel {
    
    static let availableStations: [String] = [
        "Киевский вокзал",
        "Курский вокзал",
        "Ярославский вокзал",
        "Белорусский вокзал",
        "Савеловский вокзал",
        "Ленинградский вокзал"
    ]
}
