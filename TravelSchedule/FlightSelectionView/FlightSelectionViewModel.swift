//
//  FlightSelectionViewModel.swift
//  TravelSchedule
//
//  Created by Kira on 14.08.2025.
//

import SwiftUI

@MainActor
final class FlightSelectionViewModel: ObservableObject {
    @Published var carrier: CarrierInfoModel?

    private var carrierInfoService: CarrierInfoServiceProtocol

//    private let ticket: Ticket
    
    init(carrierInfoService: CarrierInfoServiceProtocol) {
//        self.ticket = ticket
        self.carrierInfoService = carrierInfoService
    }
    
//    var operatorLogo: String {
//        ticket.operatorLogo
//    }
//    
//    var opf: String {
//        ticket.opf
//    }
//    
//    var email: String {
//        ticket.email
//    }
//    
//    var phone: String {
//        ticket.phone
//    }
    
    func fetchCarrier(code: String) async {
        do {
            let response = try await carrierInfoService.getCarrierInfo(code: code)
            guard let carrier = response.carrier else { return }
            self.carrier = CarrierInfoModel(
                code: carrier.code ?? 0,
                title: carrier.title ?? "-",
                logo: carrier.logo,
                email: carrier.email,
                phone: carrier.phone
            )
        } catch {
            print("Error: \(error)")
        }
    }
}

struct CarrierInfoModel: Identifiable, Sendable {
    var id: Int { code }
    let code: Int
    let title: String
    let logo: String?
    let email: String?
    let phone: String?
}
