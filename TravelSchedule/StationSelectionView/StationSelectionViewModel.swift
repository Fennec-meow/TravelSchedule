import SwiftUI
/// TODO
@MainActor
final class StationSelectionViewModel: ObservableObject {
    @Published var searchText: String = ""
    
    @Published var city: String = ""
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
        city: String,
        fromField: Bool,
        cities: [String] = [
            "Киевский вокзал",
            "Курский вокзал",
            "Ярославский вокзал",
            "Белорусский вокзал",
            "Савеловский вокзал",
            "Ленинградский вокзал"
        ]) {
            self.searchText = searchText
            self.city = city
            self.fromField = fromField
            self.cities = cities
        }
}
