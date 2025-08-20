//
//  APIServicesContainer.swift
//  TravelSchedule
//
//  Created by Kira on 20.08.2025.
//

import Combine

final class APIServicesContainer: ObservableObject {
    let nearestStationsService: NearestStationsServiceProtocol
    let schedualBetweenStationsService: SchedualBetweenStationsServiceProtocol
    let stationScheduleService: StationScheduleServiceProtocol
    let routeStationsService: RouteStationsServiceProtocol
    let nearestCityService: NearestCityServiceProtocol
    let carrierInfoService: CarrierInfoServiceProtocol
    let allStationsService: AllStationsServiceProtocol
    let copyrightService: CopyrightServiceProtocol
    
    init() throws {
        let client = try APIClientFactory.makeClient()
        let apikey = Apikey.apiKey
        
        self.nearestStationsService = NearestStationsService(client: client, apikey: apikey)
        self.schedualBetweenStationsService = SchedualBetweenStationsService(client: client, apikey: apikey)
        self.stationScheduleService = StationScheduleService(client: client, apikey: apikey)
        self.routeStationsService = RouteStationsService(client: client, apikey: apikey)
        self.nearestCityService = NearestCityService(client: client, apikey: apikey)
        self.carrierInfoService = CarrierInfoService(client: client, apikey: apikey)
        self.allStationsService = AllStationsService(client: client, apikey: apikey)
        self.copyrightService = CopyrightService(client: client, apikey: apikey)
    }
}
