//
//  TicketFilteringView.swift
//  TravelSchedule
//
//  Created by Kira on 17.07.2025.
//

import SwiftUI

// MARK: - TicketFilteringView

struct TicketFilteringView: View {
    
    // MARK: Private Property

    private var containsFromAndToTitle: String {
        "\(coordinator.selectedCityFrom) (\(coordinator.selectedStationFrom)) → \(coordinator.selectedCityTo) (\(coordinator.selectedStationTo))"
    }
    
    private var filteredTickets: [Ticket] {
 tickets.filter { ticket in
            if let show = coordinator.showTransfers,
               show != ticket.withTransfer
     { return false }

            guard coordinator.timeFilters.isEmpty else {
                return coordinator.timeFilters.contains(ticket.departurePeriod)
            }
            return true
        }
    }
    
    // MARK: Public Property

    @ObservedObject var coordinator: NavCoordinator
    @Environment(\.dismiss) var dismiss

    let tickets: [Ticket] = [
        .init(carrierName: "РЖД", date: "14 января", departure: "22:30", arrival: "08:15", duration: "20 часов", withTransfer: true, operatorLogo: "RJD", note: "С пересадкой в Костроме"),
        .init(carrierName: "ФГК", date: "15 января", departure: "01:15", arrival: "09:00", duration: "9 часов", withTransfer: true, operatorLogo: "FGC", note: nil),
        .init(carrierName: "Урал логистика", date: "16 января", departure: "12:30", arrival: "21:00", duration: "9 часов", withTransfer: true, operatorLogo: "uralLogistics", note: nil),
        .init(carrierName: "РЖД", date: "17 января", departure: "22:30", arrival: "08:15", duration: "20 часов", withTransfer: true, operatorLogo: "RJD", note: "С пересадкой в Костроме")
    ]

    // MARK: body

    var body: some View {
        VStack(spacing: 16) {
            FromWhereAndToWhereTitle(title: containsFromAndToTitle)
            
            ZStack(alignment: .bottom) {
                TicketsScrollView(coordinator: coordinator, tickets: filteredTickets)
                SpecifyTimeButton(coordinator: coordinator)
            }
        }
        .padding(.horizontal, 16)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton(action: { dismiss() })
            }
        }
    }
}

// MARK: - FromWhereAndToWhereTitle

private struct FromWhereAndToWhereTitle: View {
    
    // MARK: Public Property

    let title: String

    // MARK: body

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.blackForTheme)
                .multilineTextAlignment(.leading)
            Spacer()
        }
    }
}

// MARK: - TicketsScrollView

private struct TicketsScrollView: View {
    
    // MARK: Public Property

    let coordinator: NavCoordinator
    let tickets: [Ticket]

    // MARK: body

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                if tickets.isEmpty {
                    AreNoOptions()
                } else {
                    ForEach(tickets) { ticket in
                        ShowListFlights(action: {
                            coordinator.path.append(RouteEnum.flightSelection(ticket))
                        }, ticket: ticket)
                    }
                }
            }
        }
    }
}

// MARK: - AreNoOptions

private struct AreNoOptions: View {
    
    // MARK: body

    var body: some View {
        VStack {
            Text("Вариантов нет")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.blackForTheme)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 231)
        }
    }
}

// MARK: - ShowListFlights

private struct ShowListFlights: View {
    
    // MARK: Public Property

    let action: () -> Void
    let ticket: Ticket

    // MARK: body

    var body: some View {
        Button(action: action) {
            TicketCell(ticket: ticket)
        }
    }
}

// MARK: - SpecifyTimeButton

private struct SpecifyTimeButton: View {
    
    // MARK: Public Property

    @ObservedObject var coordinator: NavCoordinator

    // MARK: body

    var body: some View {
        Button(action: {
            coordinator.path.append(RouteEnum.routeParameter)
        }) {
            HStack(spacing: 4) {
                Text("Уточнить время")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(.whiteUni)

                if coordinator.isFiltersValid {
                    Circle()
                        .foregroundStyle(.redUni)
                        .frame(width: 8, height: 8)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
        }
        .background(.blueUni)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.bottom, 24)
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
    TicketFilteringView(coordinator: NavCoordinator())
}

