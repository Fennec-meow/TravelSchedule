//
//  Ticket.swift
//  TravelSchedule
//
//  Created by Kira on 16.07.2025.
//

import SwiftUI

// MARK: Ticket

struct Ticket: Identifiable, Hashable {
    let id = UUID()
    let carrierName: String
    let date: String
    let departure: String
    let arrival: String
    let duration: String
    let withTransfer: Bool
    let operatorLogo: String
    let note: String?
}

// MARK: Extension

extension Ticket {
    var departurePeriod: DepartureTime {
        let depHour = Int(departure.prefix(2)) ?? 0
        switch depHour {
        case 6..<12: return .morning
        case 12..<18: return .day
        case 18..<24: return .evening
        default: return .night
        }
    }
}
