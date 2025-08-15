//
//  FlightSelectionViewModel.swift
//  TravelSchedule
//
//  Created by Kira on 14.08.2025.
//

import SwiftUI

@MainActor
final class FlightSelectionViewModel: ObservableObject {
    
    private let ticket: Ticket
    
    init(ticket: Ticket) {
        self.ticket = ticket
    }
    
    var operatorLogo: String {
        ticket.operatorLogo
    }
    
    var opf: String {
        ticket.opf
    }
    
    var email: String {
        ticket.email
    }
    
    var phone: String {
        ticket.phone
    }
}
