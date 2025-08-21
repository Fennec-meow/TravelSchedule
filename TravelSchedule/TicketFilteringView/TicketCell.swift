import SwiftUI

// MARK: - TicketCell

struct TicketCell: View {
    
    // MARK: Public Property
    
    var ticket: Ticket
    
    // MARK: body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                TicketOperatorLogo(ticketOperatorLogo: ticket.operatorLogo)
                VStack(alignment: .leading, spacing: 2) {
                    TicketCarrierName(ticketCarrierName: ticket.carrierName)
                    TicketTransfer(ticketTransfer: ticket.transfer)
                }
                Spacer()
                
                TicketDate(ticketDate: ticket.date)
            }
            .padding(.bottom, 5)
            TicketDepartureAndArrivalTime(ticket: ticket)
        }
        .padding()
        .background(.lightGray)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}

// MARK: - TicketOperatorLogo

private struct TicketOperatorLogo: View {
    
    // MARK: Public Property
    
    var ticketOperatorLogo: String
    
    // MARK: body
    
    var body: some View {
        if let logoURL = URL(string: ticketOperatorLogo) {
            AsyncImage(url: logoURL) { image in
                switch image {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                case .failure:
                    Image(systemName: "photo.on.rectangle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 38, height: 38)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 38, height: 38)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .clipped()
        }
    }
}

// MARK: - TicketCarrierName

private struct TicketCarrierName: View {
    
    // MARK: Public Property
    
    var ticketCarrierName: String
    
    // MARK: body
    
    var body: some View {
        Text(ticketCarrierName)
            .font(.regular17)
            .foregroundColor(.blackUni)
    }
}

// MARK: - TicketTransfer

private struct TicketTransfer: View {
    
    // MARK: Public Property
    
    var ticketTransfer: String?
    
    // MARK: body
    
    var body: some View {
        if let transfer = ticketTransfer {
            Text(transfer)
                .font(.regular12)
                .foregroundColor(.redUni)
        }
    }
}

// MARK: - TicketDate

private struct TicketDate: View {
    
    // MARK: Public Property
    
    var ticketDate: String
    
    // MARK: body
    
    var body: some View {
        Text(ticketDate)
            .font(.regular12)
            .foregroundColor(.blackUni)
    }
}

// MARK: - TicketDepartureAndArrivalTime

private struct TicketDepartureAndArrivalTime: View {
    
    // MARK: Public Property
    
    var ticket: Ticket
    
    // MARK: body
    
    var body: some View {
        HStack {
            Text(ticket.departure)
                .font(.regular17)
                .foregroundStyle(.blackUni)
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.grayUni)
            Text(ticket.duration)
                .font(.regular12)
                .foregroundStyle(.blackUni)
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.grayUni)
            Text(ticket.arrival)
                .font(.regular17)
                .foregroundStyle(.blackUni)
        }
    }
}

#Preview {
    TicketCell(ticket: .init(
        code: 0,
        operatorLogo: "RJD",
        carrierName: "РЖД",
        withTransfer: true,
        transfer: "С пересадкой в Костроме",
        date: "14 января",
        departure: "22:30",
        duration: "20 часов",
        arrival: "08:15",
    ))
}
