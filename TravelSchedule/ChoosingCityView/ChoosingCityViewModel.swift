import SwiftUI

@MainActor
final class ChoosingCityViewModel: ObservableObject {
    
    @Published var searchText: String = "" {
        didSet { filterCities() }
    }
    
    @Published var station: String = ""
    @Published var direction: GoingDirection = .from
    
    @Published private(set) var cities: [String] = []
    @Published private(set) var filteredCities: [String] = []
    @Published private(set) var settlements: [Components.Schemas.Settlement] = []
    
    private var allStationsService: AllStationsServiceProtocol?
    private var allSettlements: [Components.Schemas.AllStationsResponse.CodingKeys.RawValue.Element] = []
    
    convenience init(
        service: AllStationsServiceProtocol?
    ) {
        self.init()
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
            self.settlements = settlements ?? []
            self.cities = cities
        } catch {
            print("Error: \(error)")
        }
    }
    
    func filterCities() {
        let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if text.isEmpty {
            filteredCities = cities
        } else {
            filteredCities = cities.filter { $0.localizedCaseInsensitiveContains(text) }
        }
    }
}

private extension Array where Element == String {
    func removingDuplicates() -> [String] {
        var set = Set<String>()
        return filter { set.insert($0).inserted }
    }
}
