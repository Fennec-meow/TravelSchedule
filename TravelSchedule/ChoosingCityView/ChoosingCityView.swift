import SwiftUI

// MARK: - ChoosingCityView

struct ChoosingCityView: View {
    
    // MARK: Public Property
    
    @ObservedObject var viewModel: ChoosingCityViewModel
    @ObservedObject var coordinator: NavCoordinator
    @Environment(\.dismiss) var dismiss
  
    // MARK: body
    
    var body: some View {
        VStack(spacing: 0) {
            /// TODO
            SearchTextField(text: $viewModel.searchText)
            CityScrollView(
                coordinator: coordinator,
                viewModel: viewModel
            )
        }
        .task {
            await viewModel.getCities()
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
    @ObservedObject var viewModel: ChoosingCityViewModel
    
    init(
        coordinator: NavCoordinator,
        viewModel: ChoosingCityViewModel
    ) {
        self.coordinator = coordinator
        self.viewModel = viewModel
    }
    
    // MARK: body
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading) {
                /// TODO
                if !viewModel.filteredItems.isEmpty {
                    ListCities(
                        coordinator: coordinator,
                        viewModel: viewModel
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
    @ObservedObject var viewModel: ChoosingCityViewModel
    @Environment(\.dismiss) var dismiss
    
    init(
        coordinator: NavCoordinator,
        viewModel: ChoosingCityViewModel
    ) {
        self.coordinator = coordinator
        self.viewModel = viewModel
    }
    
    // MARK: body
    
    var body: some View {
        ForEach(viewModel.filteredItems, id: \.self) { item in
            Button(action: {
                if viewModel.direction == .from {
                    coordinator.selectedCityFrom = item
                    coordinator.selectedStationFrom = viewModel.station
                } else {
                    coordinator.selectedCityTo = item
                    coordinator.selectedStationTo = viewModel.station
                }
                coordinator.path.append(
                    Route.stationSelection(
                        searchText: viewModel.searchText,
                        city: item,
                        direction: viewModel.direction,
                        stations: StationSelectionViewModel.availableStations
                    )
                )
                // TODO: CRITICAL!!! переписать под поле со станциями!
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
