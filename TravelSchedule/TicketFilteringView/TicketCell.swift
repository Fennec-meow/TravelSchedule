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
                    TicketNote(ticket: ticket)
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
            .font(.system(size: 17, weight: .regular))
            .foregroundColor(.blackUni)
    }
}

// MARK: - TicketNote

private struct TicketNote: View {
    
    // MARK: Public Property
    
    var ticket: Ticket
    
    // MARK: body
    
    var body: some View {
        if let note = ticket.note {
            Text(note)
                .font(.system(size: 12, weight: .regular))
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
            .font(.system(size: 12, weight: .regular))
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
                .font(.system(size: 17, weight: .regular))
                .foregroundStyle(.blackUni)
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.grayUni)
            Text(ticket.duration)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(.blackUni)
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.grayUni)
            Text(ticket.arrival)
                .font(.system(size: 17, weight: .regular))
                .foregroundStyle(.blackUni)
        }
    }
}

#Preview {
    TicketCell(ticket: .init(
        carrierName: "РЖД",
        date: "14 января",
        departure: "22:30",
        arrival: "08:15",
        duration: "20 часов",
        withTransfer: true,
        operatorLogo: "RJD",
        note: "С пересадкой в Костроме"
    ))
}
