//
//  StationsListService.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 18.03.2025.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias Stations = Components.Schemas.StationsList

protocol StationsListServiceProtocol {
    func getStationsList() async throws -> Stations
}

final class StationsListService: StationsListServiceProtocol {
    private let client: Client
    private let apikey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }

    func getStationsList() async throws -> Stations {
        let response = try await client.getStationsList(query: .init(
            apikey: apikey
        ))
        let httpBody = try response.ok.body.html
        let data = try await Data(collecting: httpBody, upTo: 100 * 1024 * 1024)
        let stationList = try JSONDecoder().decode(Stations.self, from: data)
        return stationList
    }
}
