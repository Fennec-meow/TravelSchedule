import SwiftUI
import OpenAPIURLSession
import OpenAPIRuntime

// MARK: - TestFetch

struct TestFetch: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                // Вызовы тестовых функций
//                testFetchStations()
//                testFetchSegments()
                testFetchScheduleResponse()
//                testFetchThreadStationsResponse()
//                testFetchNearestCityResponse()
//                testFetchCarrierResponse()
//                testFetchAllStationsResponse()
//                testFetchCopyright()
            }
    }
}

// MARK: - NearestStationsService

func testFetchStations() {
    Task {
        do {
            let client = Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport()
            )
            
            let service = NearestStationsService(
                client: client,
                apikey: Apikey.apiKey
            )
            
            print("Fetching stations...")
            let stations = try await service.getNearestStations(
                lat: 59.864177,
                lng: 30.319163,
                distance: 50
            )
            
            print("Successfully fetched stations: \(stations)")
        } catch {
            print("Error fetching stations: \(error)")
        }
    }
}

// MARK: - SchedualBetweenStationsService

func testFetchSegments() {
    Task {
        do {
            let client = Client(
                serverURL: try Servers.server1(),
                transport: URLSessionTransport()
            )
            
            let service = SchedualBetweenStationsService(
                client: client,
                apikey: Apikey.apiKey
            )
            print("Fetching service...")
            let segments = try await service.getSchedualBetweenStations(
                from: "c146",
                to: "c213"
            )
            
            print("Successfully fetched service: \(segments)")
        } catch {
            print("Error fetching service: \(error)")
        }
    }
}

// MARK: - StationScheduleService

func testFetchScheduleResponse() {
    Task {
        do {
            let client = Client(
                serverURL: try Servers.server1(),
                transport: URLSessionTransport()
            )
            
            let service = StationScheduleService(
                client: client,
                apikey: Apikey.apiKey
            )
            print("Fetching service...")
            let scheduleResponse = try await service.getStationSchedule(
                station: "s9600213"
            )
            
            print("Successfully fetched scheduleResponse: \(scheduleResponse)")
        } catch {
            print("Error fetching scheduleResponse: \(error)")
        }
    }
}

// MARK: - RouteStationsService

func testFetchThreadStationsResponse() {
    Task {
        do {
            let client = Client(
                serverURL: try Servers.server1(),
                transport: URLSessionTransport()
            )
            
            let service = RouteStationsService(
                client: client,
                apikey: Apikey.apiKey
            )
            print("Fetching service...")
            let threadStationsResponse = try await service.getRouteStations(
                uid: "018J_2_2"
            )
            
            print("Successfully fetched threadStationsResponse: \(threadStationsResponse)")
        } catch {
            print("Error fetching threadStationsResponse: \(error)")
        }
    }
}

// MARK: - NearestCityService

func testFetchNearestCityResponse() {
    Task {
        do {
            let client = Client(
                serverURL: try Servers.server1(),
                transport: URLSessionTransport()
            )
            
            let service = NearestCityService(
                client: client,
                apikey: Apikey.apiKey
            )
            print("Fetching service...")
            let nearestCityResponse = try await service.getNearestCity(
                lat: 45.023877,
                lng: 38.970157
            )
            
            print("Successfully fetched nearestCityResponse: \(nearestCityResponse)")
        } catch {
            print("Error fetching nearestCityResponse: \(error)")
        }
    }
}

// MARK: - CarrierInfoService

func testFetchCarrierResponse() {
    Task {
        do {
            let client = Client(
                serverURL: try Servers.server1(),
                transport: URLSessionTransport()
            )
            
            let service = CarrierInfoService(
                client: client,
                apikey: Apikey.apiKey
            )
            print("Fetching service...")
            let carrierResponse = try await service.getCarrierInfo(
                code: "60840"
            )
            
            print("Successfully fetched carrierResponse: \(carrierResponse)")
        } catch {
            print("Error fetching carrierResponse: \(error)")
        }
    }
}

// MARK: - AllStationsService

func testFetchAllStationsResponse() {
    Task {
        do {
            let client = Client(
                serverURL: try Servers.server1(),
                transport: URLSessionTransport()
            )
            
            let service = AllStationsService(
                client: client,
                apikey: Apikey.apiKey
            )
            print("Fetching service...")
            let allStationsResponse = try await service.getAllStations()
            
            print("Successfully fetched allStationsResponse: \(allStationsResponse)")
        } catch {
            print("Error fetching allStationsResponse: \(error)")
        }
    }
}

// MARK: - CopyrightService

func testFetchCopyright() {
    Task {
        do {
            let client = Client(
                serverURL: try Servers.server1(),
                transport: URLSessionTransport()
            )
            
            let service = CopyrightService(
                client: client,
                apikey: Apikey.apiKey
            )
            print("Fetching service...")
            let copyright = try await service.getCopyright()
            
            print("Successfully fetched copyright: \(copyright)")
        } catch {
            print("Error fetching copyright: \(error)")
        }
    }
}
#Preview {
    TestFetch()
}
