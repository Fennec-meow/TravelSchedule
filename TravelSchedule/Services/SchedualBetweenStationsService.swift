import OpenAPIRuntime
import OpenAPIURLSession

// MARK: - typealias

typealias SchedualBetweenStations = Components.Schemas.Segments

// MARK: - SchedualBetweenStationsServiceProtocol

protocol SchedualBetweenStationsServiceProtocol {
    func getSchedualBetweenStations(from: String, to: String, date: String?) async throws -> SchedualBetweenStations
}

// MARK: - SchedualBetweenStationsService

actor SchedualBetweenStationsService: SchedualBetweenStationsServiceProtocol {
    
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

extension SchedualBetweenStationsService {
    func getSchedualBetweenStations(
        from: String,
        to: String,
        date: String?
    ) async throws -> SchedualBetweenStations {
        
        let response = try await client.getSchedualBetweenStations(
            query: .init(apikey: apikey, from: from, to: to, date: date)
        )
        return try response.ok.body.json
    }
}
