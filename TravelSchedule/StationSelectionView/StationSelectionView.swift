import SwiftUI

// MARK: - StationSelectionView

struct StationSelectionView: View {

    // MARK: Public Property
    
    @StateObject var viewModel: StationSelectionViewModel
    @ObservedObject var coordinator: NavCoordinator
    @Environment(\.dismiss) var dismiss
       
    // MARK: body
    
    var body: some View {
        VStack(spacing: 0) {
           /// TODO
            SearchTextField(text: $viewModel.searchText)
            StationScrollView(
                coordinator: coordinator,
                viewModel: viewModel,
                filteredItems: viewModel.filteredItems,
                cities: viewModel.cities,
                city: viewModel.city,
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
                    StationSelectionTitle()
                }
            }
    }
}

// MARK: - StationScrollView

private struct StationScrollView: View {
    
    // MARK: Public Property
    
    @ObservedObject private var coordinator: NavCoordinator
    @State var viewModel: StationSelectionViewModel

    private let filteredItems: [String]
    private var cities: [String]
    
    private let city: String
    private let fromField: Bool
    
    init(
        coordinator: NavCoordinator,
        viewModel: StationSelectionViewModel,
        filteredItems: [String],
        cities: [String],
        city: String,
        fromField: Bool
    ) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        self.filteredItems = filteredItems
        self.cities = cities
        self.city = city
        self.fromField = fromField
    }
    
    // MARK: body
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading) {
                /// TODO
                if !viewModel.filteredItems.isEmpty {
                    ListStations(
                        coordinator: coordinator,
                        filteredItems: filteredItems,
                        city: city,
                        fromField: fromField
                    )
                } else {
                    VStack {
                        StationNotFound()
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .scrollIndicators(.hidden)
    }
}

// MARK: - ListStations

private struct ListStations: View {
    
    // MARK: Public Property
    
    @ObservedObject private var coordinator: NavCoordinator
    @Environment(\.dismiss) var dismiss
    
    private let filteredItems: [String]
    private let city: String
    private let fromField: Bool
    
    init(
        coordinator: NavCoordinator,
        filteredItems: [String],
        city: String,
        fromField: Bool
    ) {
        self.coordinator = coordinator
        self.filteredItems = filteredItems
        self.city = city
        self.fromField = fromField
    }
    
    // MARK: body
    
    var body: some View {
        ForEach(filteredItems, id: \.self) { item in
            Button(action: {
                if fromField {
                    coordinator.selectedCityFrom = city
                    coordinator.selectedStationFrom = item
                } else {
                    coordinator.selectedCityTo = city
                    coordinator.selectedStationTo = item
                }
                coordinator.path = NavigationPath()
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

// MARK: - StationNotFound

private struct StationNotFound: View {
    
    // MARK: body
    
    var body: some View {
        VStack {
            Text("Станция не найдена")
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

// MARK: - StationSelectionTitle

private struct StationSelectionTitle: View {
    
    // MARK: body
    
    var body: some View {
        Text("Выбор станции")
            .font(.bold17)
            .foregroundColor(.blackForTheme)
    }
}

//#Preview {
//    NavigationView {
//        StationSelectionView(
//            coordinator: NavCoordinator(),
//            city: "Москва",
//            fromField: true
//        )
//    }
//}
