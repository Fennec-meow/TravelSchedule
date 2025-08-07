//
//  TicketCell.swift
//  TravelSchedule
//
//  Created by Kira on 24.07.2025.
//

import SwiftUI

// MARK: - TicketCell

struct TicketCell: View {
    
    // MARK: Public Property
    
    var ticket: Ticket
    
    // MARK: body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                TicketOperatorLogo(ticket: ticket)
                VStack(alignment: .leading, spacing: 2) {
                    TicketCarrierName(ticket: ticket)
                    TicketTransfer(ticket: ticket)
                }
                Spacer()
                
                TicketDate(ticket: ticket)
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
    
    var ticket: Ticket
    
    // MARK: body
    
    var body: some View {
        Image(ticket.operatorLogo)
            .frame(width: 38, height: 38)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - TicketCarrierName

private struct TicketCarrierName: View {
    
    // MARK: Public Property
    
    var ticket: Ticket
    
    // MARK: body
    
    var body: some View {
        Text(ticket.carrierName)
            .font(.regular17)
            .foregroundColor(.blackUni)
    }
}

// MARK: - TicketTransfer

private struct TicketTransfer: View {
    
    // MARK: Public Property
    
    var ticket: Ticket
    
    // MARK: body
    
    var body: some View {
        if let transfer = ticket.transfer {
            Text(transfer)
                .font(.regular12)
                .foregroundColor(.redUni)
        }
    }
}

// MARK: - TicketDate

private struct TicketDate: View {
    
    // MARK: Public Property
    
    var ticket: Ticket
    
    // MARK: body
    
    var body: some View {
        Text(ticket.date)
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
        operatorLogo: "RJD",
        carrierName: "РЖД",
        opf: "ООО «РЖД»",
        withTransfer: true,
        transfer: "С пересадкой в Костроме",
        date: "14 января",
        departure: "22:30",
        duration: "20 часов",
        arrival: "08:15",
        email: "ticket@rzd.ru",
        phone: "+7 (800) 201-43-56"
    ))
}
