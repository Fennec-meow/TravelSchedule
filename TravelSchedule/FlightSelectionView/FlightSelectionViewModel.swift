import SwiftUI

@MainActor
final class FlightSelectionViewModel: ObservableObject {
    @Published var carrier: CarrierInfoModel?
    
    private var carrierInfoService: CarrierInfoServiceProtocol
    
    @Published var ticket: Ticket? = nil
    
    init(carrierInfoService: CarrierInfoServiceProtocol) {
        self.carrierInfoService = carrierInfoService
    }
    
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
