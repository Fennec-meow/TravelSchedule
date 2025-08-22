import OpenAPIRuntime
import OpenAPIURLSession

// MARK: - typealias

typealias RouteStations = Components.Schemas.ThreadStationsResponse

// MARK: - RouteStationsServiceProtocol

protocol RouteStationsServiceProtocol {
    func getRouteStations(uid: String) async throws -> RouteStations
}

// MARK: - RouteStationsService

actor RouteStationsService: RouteStationsServiceProtocol {
    
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

extension RouteStationsService {
    func getRouteStations(
        uid: String
    ) async throws -> RouteStations {
        
        let response = try await client.getRouteStations(query: .init(
            apikey: apikey,
            uid: uid
        ))
        return try response.ok.body.json
    }
}
