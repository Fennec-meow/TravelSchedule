import SwiftUI

// MARK: - ChoosingCityView

struct ChoosingCityView: View {
    
    // MARK: Private Property
    
    @State private var searchText = ""
    
    // MARK: Public Property
    
    @ObservedObject var coordinator: NavCoordinator
    @Environment(\.dismiss) var dismiss
    
    var filteredItems: [String] {
        guard !searchText.isEmpty else { return cities }
        return cities.filter {
            $0.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    let station: String
    let fromField: Bool
    
    let cities = [
        "Москва",
        "Санкт-Петербург",
        "Сочи",
        "Горный воздух",
        "Краснодар",
        "Казань",
        "Омск"
    ]
    
    // MARK: body
    
    var body: some View {
        VStack(spacing: 0) {
            SearchTextField(text: $searchText)
            CityScrollView(
                coordinator: coordinator,
                filteredItems: filteredItems,
                cities: cities,
                station: station,
                fromField: fromField
            )
        }
        .navigationBarTitleDisplayMode(.inline)
        Spacer()
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton(action: { dismiss() })
                }
                ToolbarItem(placement: .principal) {
                    CitySelectionTitle()
                }
            }
    }
}

// MARK: - CityScrollView

private struct CityScrollView: View {
    
    // MARK: Public Property
    
    @ObservedObject var coordinator: NavCoordinator
    @State var searchText = ""
    
    let filteredItems: [String]
    var cities: [String]
    
    let station: String
    let fromField: Bool
    
    // MARK: body
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading) {
                if !filteredItems.isEmpty {
                    ListCities(
                        coordinator: coordinator,
                        searchText: searchText,
                        filteredItems: filteredItems,
                        station: station,
                        fromField: fromField
                    )
                } else {
                    VStack {
                        CityNotFound()
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .scrollIndicators(.hidden)
    }
}

// MARK: - ListCities

private struct ListCities: View {
    
    // MARK: Public Property
    
    @ObservedObject var coordinator: NavCoordinator
    @Environment(\.dismiss) var dismiss
    
    let searchText: String
    let filteredItems: [String]
    let station: String
    let fromField: Bool
    
    // MARK: body
    
    var body: some View {
        ForEach(filteredItems, id: \.self) { item in
            Button(action: {
                
                if fromField {
                    coordinator.selectedCityFrom = item
                    coordinator.selectedStationFrom = station
                } else {
                    coordinator.selectedCityTo = item
                    coordinator.selectedStationTo = station
                }
                coordinator.path.append(RouteEnum.stationSelection(searchText: searchText, city: item, fromField: fromField))
            }) {
                HStack {
                    Text("\(item)")
                        .font(.regular17)
                        .foregroundColor(.blackForTheme)
                    Spacer()
                    
                    Image("chevronRight")
                        .renderingMode(.template)
                        .foregroundColor(.blackForTheme)
                }
                .padding(.vertical, 19)
                .contentShape(Rectangle())
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

// MARK: - CityNotFound

private struct CityNotFound: View {
    
    // MARK: body
    
    var body: some View {
        VStack {
            Text("Город не найден")
                .font(.bold24)
                .foregroundColor(.blackForTheme)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 176)
        }
    }
}

// MARK: - BackButton

private struct BackButton: View {
    
    // MARK: Public Property
    
    let action: () -> Void
    
    // MARK: body
    
    var body: some View {
        Button(action: action) {
            Image("chevronLeft")
                .renderingMode(.template)
                .foregroundColor(.blackForTheme)
        }
    }
}

// MARK: - CitySelectionTitle

private struct CitySelectionTitle: View {
    
    // MARK: body
    
    var body: some View {
        Text("Выбор города")
            .font(.bold17)
            .foregroundColor(.blackForTheme)
    }
}

#Preview {
    NavigationView {
        ChoosingCityView(
            coordinator: NavCoordinator(),
            station: "Киевский вокзал",
            fromField: true
        )
    }
}
