import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

// MARK: - typealias

typealias AllStations = Components.Schemas.AllStationsResponse

// MARK: - AllStationsServiceProtocol

protocol AllStationsServiceProtocol {
    func getAllStations() async throws -> AllStations
}

// MARK: - AllStationsService

final class AllStationsService: AllStationsServiceProtocol {
    
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

extension AllStationsService {
    func getAllStations() async throws -> AllStations {
        
        let response = try await client.getAllStations(query: .init(
            apikey: apikey
        ))
        let data = try await Data(collecting: response.ok.body.html, upTo: 1024 * 1024 * 100)
        let allStations = try JSONDecoder().decode(AllStations.self, from: data)
        
        return allStations
    }
}
