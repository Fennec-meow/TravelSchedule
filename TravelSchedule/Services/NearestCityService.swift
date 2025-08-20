import OpenAPIRuntime
import OpenAPIURLSession

// MARK: - typealias

typealias NearestCity = Components.Schemas.NearestCityResponse

// MARK: - NearestCityServiceProtocol

protocol NearestCityServiceProtocol {
    func getNearestCity(lat: Double, lng: Double) async throws -> NearestCity
}

// MARK: - NearestCityService

actor NearestCityService: NearestCityServiceProtocol {
    
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

extension NearestCityService {
    func getNearestCity(
        lat: Double,
        lng: Double
    ) async throws -> NearestCity {
        
        let response = try await client.getNearestCity(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng
        ))
        return try response.ok.body.json
    }
}
