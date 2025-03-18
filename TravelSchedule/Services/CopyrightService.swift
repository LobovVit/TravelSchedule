//
//  CopyrightService.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 18.03.2025.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias CopyrightSchedule = Components.Schemas.Copyright

protocol CopyrightServiceProtocol {
    func getCopyright() async throws -> CopyrightSchedule
}

final class CopyrightService: CopyrightServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    // Копирайт Яндекс Расписаний:
    func getCopyright() async throws -> CopyrightSchedule {
        let response = try await client.getCopyright(query: .init(
            apikey: apikey
        ))
        return try response.ok.body.json
    }
}
