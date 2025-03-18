//
//  APIClient.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 16.03.2025.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

final class APIClient {
    
    static let shared = APIClient()
    
    private let key = "22d74da3-2a60-4a6f-87de-095df592c7d0"
    private let nearestStationsService: NearestStationsService?
    private let searchService: SearchService?
    private let schedulesService: SchedulesService?
    private let threadService: ThreadService?
    private let nearestSettlementService: NearestSettlementService?
    private let carriersService: CarriersService?
    private let stationsListService: StationsListService?
    private let copyrightService: CopyrightService?
    
    private init() {
        let myURL: URL
        do {
            myURL = try Servers.Server1.url()
            print("Server URL: \(myURL)")
        } catch {
            print("Failed to get URL: \(error)")
            nearestStationsService = nil
            searchService = nil
            schedulesService = nil
            threadService = nil
            nearestSettlementService = nil
            carriersService = nil
            stationsListService = nil
            copyrightService = nil
            return
        }
        let client = Client(
            serverURL: myURL,
            transport: URLSessionTransport()
        )
        nearestStationsService = NearestStationsService(
            client: client,
            apikey: key
        )
        searchService = SearchService(
            client: client,
            apikey: key
        )
        schedulesService = SchedulesService(
            client: client,
            apikey: key
        )
        threadService = ThreadService(
            client: client,
            apikey: key
        )
        nearestSettlementService = NearestSettlementService(
            client: client,
            apikey: key
        )
        carriersService = CarriersService(
            client: client,
            apikey: key
        )
        stationsListService = StationsListService(
            client: client,
            apikey: key
        )
        copyrightService = CopyrightService(
            client: client,
            apikey: key
        )
    }
    
    
    func nearestStations() {
        Task {
            let nearestStations = try await nearestStationsService?.getNearestStations(lat: 59.864177, lng: 30.319163, distance: 50)
            print(nearestStations ?? "ERR: service is nil")
        }
    }
    
    func search() {
        Task {
            let search = try await searchService?.getSearch(from: "c146", to: "c213")
            print(search ?? "ERR: service is nil")
        }
    }
    
    func schedules() {
        Task {
            let schedules = try await schedulesService?.getSchedule(station: "s9600213", date: "2025-12-12")
            print(schedules ?? "ERR: service is nil")
        }
    }
    
    func threads() {
        Task {
            let threads = try await threadService?.getThread(uid: "FV-6431_250329_c8565_12")
            print(threads ?? "ERR: service is nil")
        }
    }
    
    func nearestSettlement() {
        Task {
            let nearestSettlement = try await nearestSettlementService?.getNearestSettlement(lat: 50.440046, lng: 40.4882367, distance: 50)
            print(nearestSettlement ?? "ERR: service is nil")
        }
    }
    
    func carriers() {
        Task {
            let carriers = try await carriersService?.getCarrier(code: "SU", system: .iata)
            print(carriers ?? "ERR: service is nil")
        }
    }
    
    func stationsList() {
        Task {
            let stationsList = try await stationsListService?.getStationsList()
            guard let countries = stationsList?.countries else { return }
            print("Countries count:", countries.count)
            var totalStations = 0
            countries.forEach {
                $0.regions?.forEach {
                    $0.settlements?.forEach {
                        $0.stations?.forEach { _ in totalStations += 1 }
                    }
                }
            }
            print("Stations count: \(totalStations)")
        }
    }
    
    func copyright() {
        Task {
            let copyright = try await copyrightService?.getCopyright()
            print(copyright ?? "ERR: service is nil")
        }
    }
}
