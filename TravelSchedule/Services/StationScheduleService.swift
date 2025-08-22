import OpenAPIRuntime
import OpenAPIURLSession

// MARK: - typealias

typealias StationSchedule = Components.Schemas.ScheduleResponse

// MARK: - StationScheduleServiceProtocol

protocol StationScheduleServiceProtocol {
    func getStationSchedule(station: String) async throws -> StationSchedule
}

// MARK: - StationScheduleService

actor StationScheduleService: StationScheduleServiceProtocol {
    
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

extension StationScheduleService {
    func getStationSchedule(
        station: String
    ) async throws -> StationSchedule {
        
        let response = try await client.getStationSchedule(query: .init(
            apikey: apikey,
            station: station,
            date: "2025-08-19"
        ))
        return try response.ok.body.json
    }
}
