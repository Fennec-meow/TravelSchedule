//
//  RouteParameterClarificationsView.swift
//  TravelSchedule
//
//  Created by Kira on 22.07.2025.
//

import SwiftUI

// MARK: - RouteParameterClarificationsView

struct RouteParameterClarificationsView: View {
    
    // MARK: Public Property

    @ObservedObject var coordinator: NavCoordinator
    @Environment(\.dismiss) var dismiss
    
    // MARK: body

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            DepartureTimeTitle()
            AnnouncementDepartureTime(coordinator: coordinator)
            TransferOptionsTitle()
            
            HStack {
                ShowTransfers(coordinator: coordinator)
            }
            HStack {
                NotShowTransfers(coordinator: coordinator)
            }
            Spacer()
            ApplyButton(coordinator: coordinator)
        }
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton(action: { dismiss() })
            }
        }
    }
}

// MARK: - DepartureTimeTitle

private struct DepartureTimeTitle: View {
    
    // MARK: body

    var body: some View {
        Text("Время отправления")
            .font(.system(size: 24, weight: .bold))
            .foregroundStyle(.blackForTheme)
    }
}

// MARK: - AnnouncementDepartureTime

private struct AnnouncementDepartureTime: View {
    
    // MARK: Public Property

    @ObservedObject var coordinator: NavCoordinator
    
    // MARK: body

    var body: some View {
        ForEach(DepartureTime.allCases, id: \.self) { time in
            HStack {
                Text(time.rawValue)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.blackForTheme)
                Spacer()
                Button(action: {
                    if coordinator.timeFilters.contains(time) {
                        coordinator.timeFilters.remove(time)
                    } else {
                        coordinator.timeFilters.insert(time)
                    }
                }) {
                    Image(systemName: coordinator.timeFilters.contains(time) ? "checkmark.square.fill" : "square")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.blackForTheme)
                }
            }
            .frame(height: 60)
            .padding(.trailing, 2)
        }
    }
}

// MARK: - TransferOptionsTitle

private struct TransferOptionsTitle: View {
    
    // MARK: body

    var body: some View {
        Text("Показывать варианты с пересадками")
            .font(.system(size: 20, weight: .bold))
            .padding(.top, 16)
    }
}

// MARK: - ShowTransfers

private struct ShowTransfers: View {
    
    // MARK: Public Property

    @ObservedObject var coordinator: NavCoordinator
    
    // MARK: body

    var body: some View {
        Text("Да")
            .font(.system(size: 17, weight: .regular))
            .foregroundStyle(.blackForTheme)
        Spacer()
        Button(action: { coordinator.showTransfers = true }) {
            Image(coordinator.showTransfers == true ? "power_button_on" : "power_button_off")
                .renderingMode(.template)
                .resizable()
                .foregroundStyle(.blackForTheme)
                .frame(width: 24, height: 24)
        }
        .frame(height: 60)
        .padding(.trailing, 2)
    }
}

// MARK: - NotShowTransfers

private struct NotShowTransfers: View {
    
    // MARK: Public Property

    @ObservedObject var coordinator: NavCoordinator
    
    // MARK: body

    var body: some View {
        Text("Нет")
            .font(.system(size: 17, weight: .regular))
            .foregroundStyle(.blackForTheme)
        Spacer()
        Button(action: { coordinator.showTransfers = false }) {
            Image(coordinator.showTransfers == false ? "power_button_on" : "power_button_off")
                .renderingMode(.template)
                .resizable()
                .foregroundStyle(.blackForTheme)
                .frame(width: 24, height: 24)
        }
        .frame(height: 60)
        .padding(.trailing, 2)
    }
}

// MARK: - ApplyButton

private struct ApplyButton: View {
    
    // MARK: Public Property

    @ObservedObject var coordinator: NavCoordinator
    
    // MARK: body

    var body: some View {
        if coordinator.isFiltersValid {
            Button(action: {coordinator.path.removeLast()}) {
                Text("Применить")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(.whiteUni)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
            }
            .background(.blueUni)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.bottom, 24)
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
            Image(.chevronLeft)
                .renderingMode(.template)
                .foregroundStyle(.blackForTheme)
        }
    }
}

#Preview {
    RouteParameterClarificationsView(coordinator: NavCoordinator())
}
