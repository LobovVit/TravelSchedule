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
    
    @MainActor static let shared = APIClient()
    
    private let key = "22d74da3-2a60-4a6f-87de-095df592c7d0"
    private let searchService: SearchService?
    private let stationsListService: StationsListService?
    
    private var cacheSettlements: [Components.Schemas.Settlements] = []
    
    private init() {
        let myURL: URL
        do {
            myURL = try Servers.Server1.url()
            print("Server URL: \(myURL)")
        } catch {
            print("Failed to get URL: \(error)")
            searchService = nil
            stationsListService = nil
            return
        }
        let client = Client(
            serverURL: myURL,
            transport: URLSessionTransport()
        )
        searchService = SearchService(
            client: client,
            apikey: key
        )
        stationsListService = StationsListService(
            client: client,
            apikey: key
        )
    }
    
    func fetchStations() async throws -> [Components.Schemas.Settlements] {
        if !cacheSettlements.isEmpty { return cacheSettlements }
        let stationsList = try await stationsListService?.getStationsList()
        guard let countries = stationsList?.countries else { throw AppErrorType.serverError }
        countries.forEach {
            if $0.title != "Россия" { return }
            $0.regions?.forEach {
                if $0.title?.isEmpty ?? true { return }
                $0.settlements?.forEach { settlement in
                    cacheSettlements.append(settlement)
                }
            }
        }
        return cacheSettlements
    }
    
    func fetchRoutes(from departure: Station, to arrival: Station) async throws -> [Components.Schemas.Segment] {
        let routes = try await searchService?.getSearch(from: departure.code, to: arrival.code)
        guard let segments = routes?.segments else { throw AppErrorType.serverError }
        return segments
    }
    
}
