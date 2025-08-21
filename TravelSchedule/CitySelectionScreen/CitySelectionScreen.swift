import SwiftUI

// MARK: - CitySelectionScreen

struct CitySelectionScreen: View {
    
    // MARK: Private Property
    
    @ObservedObject private var storiesViewModel = StoriesViewModel()
    @ObservedObject var choosingCityViewModel: ChoosingCityViewModel
    
    // MARK: Public Property
    
    @ObservedObject var coordinator: NavCoordinator
    @State private var containsFromAndTo = true
    @State var viewedStories: Bool = false
    
    init(
        coordinator: NavCoordinator,
        choosingCityViewModel: ChoosingCityViewModel
    ) {
        self.coordinator = coordinator
        self.choosingCityViewModel = choosingCityViewModel
    }
    
    // MARK: body
    
    var body: some View {
        NavigationView {
            VStack(spacing: 44) {
                ShowStoriesScrollView(storiesViewModel: storiesViewModel, viewedStories: viewedStories)
                
                ChoosingDirection(coordinator: coordinator ,viewModel: choosingCityViewModel, containsFromAndTo: $containsFromAndTo)
            }
            .padding(.top, 24)
        }
    }
}

// MARK: - ShowStoriesScrollView

private struct ShowStoriesScrollView: View {
    
    // MARK: Public Property
    
    @ObservedObject private var storiesViewModel: StoriesViewModel ///
    @State var viewedStories: Bool
    
    init(storiesViewModel: StoriesViewModel, viewedStories: Bool) {
        self.storiesViewModel = storiesViewModel
        self.viewedStories = viewedStories
    }
    // MARK: body
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(alignment: .center, spacing: 12) {
                ForEach(storiesViewModel.storiesGroups.compactMap { $0.isEmpty ? nil : $0 }, id: \.self) { storiesGroup in
                    StoriesCell(stories: storiesGroup, isViewed: $viewedStories)
                }
            }
        }
        .frame(height: 140)
        .padding(.horizontal, 16)
        .scrollIndicators(.hidden)
    }
}

// MARK: - ChoosingDirection

private struct ChoosingDirection: View {
    
    // MARK: Public Property
    
    @ObservedObject var coordinator: NavCoordinator
    @ObservedObject var viewModel: ChoosingCityViewModel
    @Binding var containsFromAndTo: Bool
    
    // MARK: body
    
    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                BackgroundContainsFromAndTo()
                
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        NavigationLinkWhereFrom(coordinator: coordinator,viewModel: viewModel, containsFromAndTo: $containsFromAndTo)
                        NavigationLinkWhere(coordinator: coordinator, viewModel: viewModel, containsFromAndTo: $containsFromAndTo)
                    }
                    .frame(width: 259, height: 96)
                    .background(RoundedRectangle(cornerRadius: 20)
                        .fill(.whiteUni)
                    )
                    .padding(.horizontal, 16)
                    
                    CityChangeButton(
                        coordinator: coordinator,
                        containsFromAndTo: $containsFromAndTo,
                        action: { containsFromAndTo.toggle() })
                }
                .padding(.vertical, 16)
            }
            .frame(height: 128)
            .padding(.horizontal, 16)
            
            TheFindButton(coordinator: coordinator)
        }
        Spacer()
        
        Divider()
            .frame(height: 3)
    }
}

// MARK: - BackgroundContainsFromAndTo

private struct BackgroundContainsFromAndTo: View {
    
    // MARK: body
    
    var body: some View {
        Color(UIColor(resource: .blueUni))
            .frame(width: 343, height: 128)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

// MARK: - NavigationLinkWhereFrom

private struct NavigationLinkWhereFrom: View {
    
    // MARK: Public Property
    
    @ObservedObject var coordinator: NavCoordinator
    @ObservedObject var viewModel: ChoosingCityViewModel
    @Binding var containsFromAndTo: Bool
    
    // MARK: body
    
    var body: some View {
        /// TODO
        NavigationLink(value: Route.choosingCity(
            searchText: viewModel.searchText,
            station: viewModel.station,
            direction: viewModel.direction,
            cities: viewModel.cities
        )) {
            Text(containsFromAndTo ? (
                coordinator.selectedCityFrom.isEmpty ? "Откуда" :
                    "\(coordinator.selectedCityFrom) (\(coordinator.selectedStationFrom))") :
                    (coordinator.selectedCityTo.isEmpty ? "Куда" :
                        "\(coordinator.selectedCityTo) (\(coordinator.selectedStationTo))")
            )
            .foregroundStyle(
                (containsFromAndTo
                 ? coordinator.selectedCityFrom.isEmpty
                 : coordinator.selectedCityTo.isEmpty
                )
                ? .gray
                : .blackUni
            )
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

// MARK: - NavigationLinkWhere

private struct NavigationLinkWhere: View {
    
    // MARK: Public Property
    
    @ObservedObject var coordinator: NavCoordinator
    @ObservedObject var viewModel: ChoosingCityViewModel
    @Binding var containsFromAndTo: Bool
    
    // MARK: body
    
    var body: some View {
        /// TODO
        NavigationLink(value: Route.choosingCity(
            searchText: viewModel.searchText,
            station: viewModel.station,
            direction: .where,
            cities: viewModel.cities
        )) {
            Text(containsFromAndTo ? (
                coordinator.selectedCityTo.isEmpty ? "Куда" :
                    "\(coordinator.selectedCityTo) (\(coordinator.selectedStationTo))") :
                    (coordinator.selectedCityFrom.isEmpty ? "Откуда" :
                        "\(coordinator.selectedCityFrom) (\(coordinator.selectedStationFrom))"))
            .foregroundStyle(
                (containsFromAndTo
                 ? coordinator.selectedCityTo.isEmpty
                 : coordinator.selectedCityFrom.isEmpty
                )
                ? .gray
                : .blackUni
            )
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

// MARK: - CityChangeButton

private struct CityChangeButton: View {
    
    // MARK: Public Property
    
    @ObservedObject var coordinator: NavCoordinator
    @Binding var containsFromAndTo: Bool
    
    let action: () -> Void
    
    // MARK: body
    
    var body: some View {
        Button(action: {
            let tempCity = coordinator.selectedCityFrom
            let tempStation = coordinator.selectedStationFromCode
            
            coordinator.selectedCityFrom = coordinator.selectedCityTo
            coordinator.selectedStationFrom = coordinator.selectedStationToCode
            
            coordinator.selectedCityTo = tempCity
            coordinator.selectedStationToCode = tempStation
            
            containsFromAndTo.toggle()
            action()
        }) {
            Image(.cityChangeButton)
            //                .resizable()
                .frame(width: 36, height: 36)
                .background(Color(UIColor(resource: .whiteUni)))
                .clipShape(RoundedRectangle(cornerRadius: 24))
        }
        .padding(.trailing, 16)
    }
}

// MARK: - TheFindButton

private struct TheFindButton: View {
    
    // MARK: Public Property
    
    @ObservedObject var coordinator: NavCoordinator
    
    // MARK: body
    
    var body: some View {
        if !coordinator.selectedCityTo.isEmpty && !coordinator.selectedCityFrom.isEmpty {
            Button(action: {
                coordinator.path.append(Route.ticketFiltering)
            }) {
                Text("Найти")
                    .font(.bold17)
                    .foregroundStyle(.whiteUni)
            }
            .padding(.horizontal, 47.5)
            .padding(.vertical, 20)
            .background(.blueUni)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}
