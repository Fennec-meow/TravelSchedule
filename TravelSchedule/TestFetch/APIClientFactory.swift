import OpenAPIURLSession

final class APIClientFactory {
    static func makeClient() throws -> Client {
        try Client(
            serverURL: Servers.Server1.url(),
            transport: URLSessionTransport()
        )
    }
}
