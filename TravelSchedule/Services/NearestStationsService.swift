import OpenAPIRuntime
import OpenAPIURLSession

// MARK: - typealias

typealias NearestStations = Components.Schemas.Stations

// MARK: - NearestStationsServiceProtocol

protocol NearestStationsServiceProtocol {
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations
}

// MARK: - NearestStationsService

final class NearestStationsService: NearestStationsServiceProtocol {
    
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

extension NearestStationsService {
    func getNearestStations(
        lat: Double,
        lng: Double,
        distance: Int
    ) async throws -> NearestStations {
        
        let response = try await client.getNearestStations(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng,
            distance: distance
        ))
        return try response.ok.body.json
    }
}
