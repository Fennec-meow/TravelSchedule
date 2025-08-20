import SwiftUI
/// TODO
@MainActor
final class ChoosingCityViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    
    @Published var station: String = ""
    @Published var direction: GoingDirection = .from
    
    @Published var cities: [String] = []
    
    private var allStationsService: AllStationsServiceProtocol?

    var filteredItems: [String] {
        guard !searchText.isEmpty else { return cities }
        return cities.filter {
            $0.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    convenience init(
//        searchText: String,
//        station: String,
//        direction: GoingDirection,
//        cities: [String]
        service: AllStationsServiceProtocol?
    ) {
        self.init()
//        self.searchText = searchText
//        self.station = station
//        self.direction = direction
//        self.cities = cities
        self.allStationsService = service
    }
}

// MARK: - Public Methods

extension ChoosingCityViewModel {
    func getCities() async {
        do {
            let response = try await allStationsService?.getAllStations()
            let settlements = response?.countries?
                .filter { $0.title == "Россия" }
                .flatMap { $0.regions ?? [] }
                .flatMap { $0.settlements ?? [] }
            let cities = settlements?
                .compactMap { $0.title }
                .filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
                .removingDuplicates() ?? []
            // станции - settlements?.first?.stations
            self.cities = cities
        } catch {
            print("Error: \(error)")
        }
    }
}

private extension Array where Element == String {
    func removingDuplicates() -> [String] {
        var set = Set<String>()
        return filter { set.insert($0).inserted }
    }
}
