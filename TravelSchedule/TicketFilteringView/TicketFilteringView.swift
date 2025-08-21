import SwiftUI

// MARK: - TicketFilteringView

struct TicketFilteringView: View {
    
    // MARK: Private Property
    @ObservedObject var viewModel: TicketFilteringViewModel
    
    var containsFromAndToTitle: String {
        "\(coordinator.selectedStationFrom) → \(coordinator.selectedStationTo)"
    }
    // MARK: Public Property
    
    @ObservedObject var coordinator: NavCoordinator
    @Environment(\.dismiss) var dismiss
    
    // MARK: body
    
    var body: some View {
        VStack(spacing: 16) {
            FromWhereAndToWhereTitle(title: containsFromAndToTitle)
            
            ZStack(alignment: .bottom) {
                TicketsScrollView(
                    viewModel: viewModel,
                    coordinator: coordinator,
                )
                SpecifyTimeButton(coordinator: coordinator)
            }
        }
        .task {
            viewModel.coordinator = self.coordinator
            viewModel.toStation = coordinator.selectedStationToCode
            viewModel.fromStation = coordinator.selectedStationFromCode
            await viewModel.fetchTickets()
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
    @ObservedObject var viewModel: TicketFilteringViewModel
    
    let coordinator: NavCoordinator
    
    // MARK: body
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                if !viewModel.tickets.isEmpty {
                    ForEach(viewModel.filteredTickets) { ticket in
                        ShowListFlights(action: {
                            coordinator.path.append(Route.flightSelection(ticket))
                        }, ticket: ticket)
                    }
                } else {
                    AreNoOptions()
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
            coordinator.path.append(Route.routeParameter)
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
