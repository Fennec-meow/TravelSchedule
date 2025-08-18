import SwiftUI
/// TODO
@MainActor
final class ChoosingCityViewModel: ObservableObject {
    @Published var searchText: String = ""
    
    @Published var station: String
    @Published var fromField: Bool
    
    @Published var cities: [String] = []
    
    var filteredItems: [String] {
        guard !searchText.isEmpty else { return cities }
        return cities.filter {
            $0.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    init(
        searchText: String,
        station: String,
        fromField: Bool,
        cities: [String] = [
            "Москва",
            "Санкт-Петербург",
            "Сочи",
            "Горный воздух",
            "Краснодар",
            "Казань",
            "Омск"
        ]) {
            self.searchText = searchText
            self.station = station
            self.fromField = fromField
            self.cities = cities
        }
}
