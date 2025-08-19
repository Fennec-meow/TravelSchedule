import SwiftUI
/// TODO
//@MainActor
final class ChoosingCityViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    
    @Published var station: String = ""
    @Published var direction: GoingDirection = .from
    
    @Published var cities: [String] = [
        "Москва",
        "Санкт-Петербург",
        "Сочи",
        "Горный воздух",
        "Краснодар",
        "Казань",
        "Омск"
    ]
    
    var filteredItems: [String] {
        guard !searchText.isEmpty else { return cities }
        return cities.filter {
            $0.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    convenience init(
        searchText: String,
        station: String,
        direction: GoingDirection,
        cities: [String]
    ) {
        self.init()
        self.searchText = searchText
        self.station = station
        self.direction = direction
        self.cities = cities
    }
}
