//
//  StationSelectionView.swift
//  TravelSchedule
//
//  Created by Kira on 15.07.2025.
//

import SwiftUI

// MARK: - StationSelectionView

struct StationSelectionView: View {
    
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
    
    let city: String
    let fromField: Bool
    
    let cities = [
        "Киевский вокзал",
        "Курский вокзал",
        "Ярославский вокзал",
        "Белорусский вокзал",
        "Савеловский вокзал",
        "Ленинградский вокзал"
    ]
    
    // MARK: body
    
    var body: some View {
        VStack(spacing: 0) {
            SearchTextField(text: $searchText)
            StationScrollView(
                coordinator: coordinator,
                filteredItems: filteredItems,
                cities: cities,
                city: city,
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
                StationSelectionTitle()
            }
        }
    }
}

// MARK: - StationScrollView

private struct StationScrollView: View {
    
    // MARK: Public Property
    
    @ObservedObject var coordinator: NavCoordinator
    @State var searchText = ""
    
    let filteredItems: [String]
    var cities: [String]
    
    let city: String
    let fromField: Bool
    
    // MARK: body
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading) {
                if !filteredItems.isEmpty {
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
    
    @ObservedObject var coordinator: NavCoordinator
    @Environment(\.dismiss) var dismiss
    
    let filteredItems: [String]
    let city: String
    let fromField: Bool
    
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

#Preview {
    NavigationView {
        StationSelectionView(
            coordinator: NavCoordinator(),
            city: "Москва",
            fromField: true
        )
    }
}
