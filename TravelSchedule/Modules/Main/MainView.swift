//
//  MainView.swift
//  TravelSchedule
//
//  Created by Kira on 01.07.2025.
//

import SwiftUI
import OpenAPIURLSession
import OpenAPIRuntime

// MARK: - MainView

struct MainView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            // Вызовы тестовых функций
            testFetchStations()
//            testFetchSegments()
//            testFetchScheduleResponse()
//            testFetchThreadStationsResponse()
//            testFetchNearestCityResponse()
//            testFetchCarrierResponse()
//            testFetchAllStationsResponse()
//            testFetchCopyright()
        }
    }
}

// MARK: - NearestStationsService

func testFetchStations() {
    Task {
        do {
            let client = Client(
                serverURL: try Servers.server1(),
                transport: URLSessionTransport()
            )
            
            let service = NearestStationsService(
                client: client,
                apikey: "dea87870-927b-418f-a06d-f0eea98e84a4"
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
                apikey: "dea87870-927b-418f-a06d-f0eea98e84a4"
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
                apikey: "dea87870-927b-418f-a06d-f0eea98e84a4"
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
                apikey: "dea87870-927b-418f-a06d-f0eea98e84a4"
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
                apikey: "dea87870-927b-418f-a06d-f0eea98e84a4"
            )
            print("Fetching service...")
            let nearestCityResponse = try await service.getNearestCity(
                lat: 59.86580221563463,
                lng: 30.320322626983558
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
                apikey: "dea87870-927b-418f-a06d-f0eea98e84a4"
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
                apikey: "dea87870-927b-418f-a06d-f0eea98e84a4"
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
                apikey: "dea87870-927b-418f-a06d-f0eea98e84a4"
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
    MainView()
}
