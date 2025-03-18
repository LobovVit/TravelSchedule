//
//  SearchService.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 16.03.2025.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias SearchRoutes = Components.Schemas.RoutesList

protocol SearchServiceProtocol {
    func getSearch(from: String, to: String) async throws -> SearchRoutes
}

final class SearchService: SearchServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    // Расписание рейсов между станциями:
    func getSearch(from: String, to: String) async throws -> SearchRoutes {
        let response = try await client.getSearch(query: .init(
            apikey: apikey,
            from: from,
            to: to
        ))
        return try response.ok.body.json
    }
}
