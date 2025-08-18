import SwiftUI

// MARK: - ChoosingCityView

struct ChoosingCityView: View {
    
    // MARK: Public Property
    
    @StateObject var viewModel: ChoosingCityViewModel
    @ObservedObject var coordinator: NavCoordinator
    @Environment(\.dismiss) var dismiss
  
    // MARK: body
    
    var body: some View {
        VStack(spacing: 0) {
            /// TODO
            SearchTextField(text: $viewModel.searchText)
            CityScrollView(
                coordinator: coordinator,
                viewModel: viewModel,
                searchText: viewModel.searchText,
                filteredItems: viewModel.filteredItems,
                cities: viewModel.cities,
                station: viewModel.station,
                fromField: viewModel.fromField
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
    
    /// TODO
    @ObservedObject var coordinator: NavCoordinator
    @State var viewModel: ChoosingCityViewModel

    @State var searchText = ""
    
    private let filteredItems: [String]
    private var cities: [String]
    
    private let station: String
    private let fromField: Bool
    
    init(
        coordinator: NavCoordinator,
        viewModel: ChoosingCityViewModel,
        searchText: String,
        filteredItems: [String],
        cities: [String],
        station: String,
        fromField: Bool
    ) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        self.searchText = searchText
        self.filteredItems = filteredItems
        self.cities = cities
        self.station = station
        self.fromField = fromField
    }
    
    // MARK: body
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading) {
                /// TODO
                if !viewModel.filteredItems.isEmpty {
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
    /// TODO
    @ObservedObject private var coordinator: NavCoordinator
    @Environment(\.dismiss) var dismiss
    
    private let searchText: String
    private let filteredItems: [String]
    private let station: String
    private let fromField: Bool
    
    init(
        coordinator: NavCoordinator,
        searchText: String,
        filteredItems: [String],
        station: String,
        fromField: Bool
    ) {
        self.coordinator = coordinator
        self.searchText = searchText
        self.filteredItems = filteredItems
        self.station = station
        self.fromField = fromField
    }
    
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
//
//#Preview {
//    NavigationView {
//        ChoosingCityView(
//            coordinator: NavCoordinator(),
//            station: "Киевский вокзал",
//            fromField: true
//        )
//    }
//}
