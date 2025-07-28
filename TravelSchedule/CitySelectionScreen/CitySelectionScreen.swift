//
//  CitySelectionScreen.swift
//  TravelSchedule
//
//  Created by Kira on 14.07.2025.
//

import SwiftUI

// MARK: - CitySelectionScreen

struct CitySelectionScreen: View {
    
    // MARK: Private Property
    
    @StateObject private var viewModel = StoriesViewModel()
    
    // MARK: Public Property
    
    @ObservedObject var coordinator: NavCoordinator
    @State private var containsFromAndTo = true
    
    // MARK: body
    
    var body: some View {
        VStack(spacing: 44) {
            ShowStoriesScrollView()
            
            ChoosingDirection(coordinator: coordinator, containsFromAndTo: $containsFromAndTo)
        }
        .padding(.top, 24)
    }
}

// MARK: - ShowStoriesScrollView

private struct ShowStoriesScrollView: View {
    
    // MARK: Public Property
    
    @StateObject var viewModel = StoriesViewModel()
    
    // MARK: body
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(alignment: .center, spacing: 12) {
                ForEach(viewModel.stories) { story in
                    StoriesCell(story: story)
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
    @Binding var containsFromAndTo: Bool
    
    // MARK: body
    
    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                BackgroundContainsFromAndTo()
                
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        NavigationLinkWhereFrom(coordinator: coordinator, containsFromAndTo: $containsFromAndTo)
                        NavigationLinkWhere(coordinator: coordinator, containsFromAndTo: $containsFromAndTo)
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
    @Binding var containsFromAndTo: Bool
    
    // MARK: body
    
    var body: some View {
        NavigationLink(value: RouteEnum.choosingCity(station: "", fromField: true)) {
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
    @Binding var containsFromAndTo: Bool
    
    // MARK: body
    
    var body: some View {
        NavigationLink(value: RouteEnum.choosingCity(station: "", fromField: false)) {
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
            let tempStation = coordinator.selectedStationFrom
            
            coordinator.selectedCityFrom = coordinator.selectedCityTo
            coordinator.selectedStationFrom = coordinator.selectedStationTo
            
            coordinator.selectedCityTo = tempCity
            coordinator.selectedStationTo = tempStation
            
            containsFromAndTo.toggle()
            action()
        }) {
            Image("cityChangeButton")
                .font(.system(size: 24))
                .foregroundStyle(.blueUni)
                .padding(6)
                .background(Color(UIColor(resource: .whiteUni)))
                .clipShape(RoundedRectangle(cornerRadius: 40))
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
                coordinator.path.append(RouteEnum.ticketFiltering)
            }) {
                Text("Найти")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(.whiteUni)
            }
            .padding(.horizontal, 47.5)
            .padding(.vertical, 20)
            .background(.blueUni)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}

#Preview {
    MainView(coordinator: NavCoordinator())
}
