//import SwiftUI
///// TODO
//@MainActor
//final class StationSelectionViewModel: ObservableObject {
//
//    @Published var searchText: String = ""
//    @Published var city: String = ""
//    @Published var direction: GoingDirection = .where
//    @Published var stations: [String] = [
//        "Киевский вокзал",
//        "Курский вокзал",
//        "Ярославский вокзал",
//        "Белорусский вокзал",
//        "Савеловский вокзал",
//        "Ленинградский вокзал"
//    ]
//
////    private var stationScheduleService: StationScheduleServiceProtocol
//
//    var filteredItems: [String] {
//        guard !searchText.isEmpty else { return stations }
//        return stations.filter {
//            $0.localizedCaseInsensitiveContains(searchText)
//        }
//    }
//
//    convenience init(
//        searchText: String,
//        city: String,
//        direction: GoingDirection,
//        stations: [String]
////        stationScheduleService: StationScheduleServiceProtocol
//    ) {
//        self.init()
//        self.searchText = searchText
//        self.city = city
//        self.direction = direction
//        self.stations = stations
////        self.stationScheduleService = stationScheduleService
//    }
//}
//
//extension StationSelectionViewModel {
//
//    static let availableStations: [String] = [
//        "Киевский вокзал",
//        "Курский вокзал",
//        "Ярославский вокзал",
//        "Белорусский вокзал",
//        "Савеловский вокзал",
//        "Ленинградский вокзал"
//    ]
//}


import SwiftUI
/// TODO
@MainActor
final class StationSelectionViewModel: ObservableObject {
    
    @Published private(set) var allStations: [StationModel] = []
    @Published private(set) var filteredStations: [StationModel] = []
    
    
    @Published var searchText: String = ""
    @Published var city: String = ""
    @Published var direction: GoingDirection = .where
    @Published var stations: [Components.Schemas.Station] = [] {
        didSet { createStationsForView() }
    }
    @Published var stationsForView: [String] = []
    
    private var allStationsService: AllStationsServiceProtocol?
    private var loadTask: Task<Void, Never>?
    
    convenience init(
        city: String,
        service: AllStationsServiceProtocol?
    ) {
        self.init()
        self.city = city
        self.allStationsService = service
    }
}

extension StationSelectionViewModel {
    func createStationsForView() {
        stationsForView = stations
            .compactMap { $0.title ?? String() }
    }
}


private extension Array where Element == StationModel {
    func removingDuplicates() -> [StationModel] {
        var set = Set<String>()
        return filter { set.insert($0.id).inserted }
    }
}

struct StationModel: Identifiable, Sendable {
    let id: String
    let title: String
}
