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
        .init(
            operatorLogo: "RJD",
            carrierName: "РЖД",
            opf: "ОАО «РЖД»",
            withTransfer: true,
            transfer: "С пересадкой в Костроме",
            date: "14 января",
            departure: "22:30",
            duration: "20 часов",
            arrival: "08:15",
            email: "ticket@rzd.ru",
            phone: "+7 (800) 201-43-56"
        ),
        .init(
            operatorLogo: "FGC",
            carrierName: "ФГК",
            opf: "АО «ФГК»",
            withTransfer: true,
            transfer: nil,
            date: "15 января",
            departure: "01:15",
            duration: "9 часов",
            arrival: "09:00",
            email: "info@railfgk.ru",
            phone: "+7 (800) 250-47-77"
        ),
        .init(
            operatorLogo: "uralLogistics",
            carrierName: "Урал логистика",
            opf: "ООО «Урал логистика»",
            withTransfer: true,
            transfer: nil,
            date: "16 января",
            departure: "12:30",
            duration: "9 часов",
            arrival: "21:00",
            email: "general@ulgroup.ru",
            phone: "+7 (495) 783-83-83"
        ),
        .init(
            operatorLogo: "RJD",
            carrierName: "РЖД",
            opf: "ОАО «РЖД»",
            withTransfer: true,
            transfer: "С пересадкой в Костроме",
            date: "17 января",
            departure: "22:30",
            duration: "20 часов",
            arrival: "08:15",
            email: "ticket@rzd.ru",
            phone: "+7 (800) 201-43-56"
        )
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
                .font(.bold24)
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
                .font(.bold24)
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
                    .font(.bold17)
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
