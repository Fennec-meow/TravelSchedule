import OpenAPIRuntime
import OpenAPIURLSession

// MARK: - typealias

typealias Copyright = Components.Schemas.Copyright

// MARK: - CopyrightServiceProtocol

protocol CopyrightServiceProtocol {
    func getCopyright() async throws -> Copyright
}

// MARK: - CopyrightService

final class CopyrightService: CopyrightServiceProtocol {
    
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

extension CopyrightService {
    func getCopyright() async throws -> Copyright {
        
        let response = try await client.getCopyright(query: .init(
            apikey: apikey
        ))
        return try response.ok.body.json
    }
}
