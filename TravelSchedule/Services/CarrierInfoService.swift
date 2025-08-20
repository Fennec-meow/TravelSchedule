import OpenAPIRuntime
import OpenAPIURLSession

// MARK: - typealias

typealias CarrierInfo = Components.Schemas.CarrierResponse

// MARK: - CarrierInfoServiceProtocol

protocol CarrierInfoServiceProtocol {
    func getCarrierInfo(code: String) async throws -> CarrierInfo
}

// MARK: - CarrierInfoService

actor CarrierInfoService {
    
    // MARK: Private Property
    
    private let client: Client
    private let apikey: String
    
    // MARK: Lifecycle
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
}

// MARK: - Public Methods

extension CarrierInfoService: CarrierInfoServiceProtocol {
    func getCarrierInfo(
        code: String
    ) async throws -> CarrierInfo {
        
        let response = try await client.getCarrierInfo(query: .init(
            apikey: apikey,
            code: code
        ))
        return try response.ok.body.json
    }
}
