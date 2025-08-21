import SwiftUI

// MARK: Ticket struct

struct Ticket: Identifiable, Hashable, Sendable {
    let id = UUID()
    let code: Int?
    let operatorLogo: String
    let carrierName: String
    let withTransfer: Bool
    let transfer: String?
    let date: String
    let departure: String
    let duration: String
    let arrival: String
}

// MARK: Extension + departurePeriod

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
