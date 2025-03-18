//
//  CarriersService.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 18.03.2025.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias Carriers = Components.Schemas.Carriers
typealias CarrierSystem = Operations.getCarrier.Input.Query.systemPayload

protocol CarriersServiceProtocol {
    func getCarrier(code: String, system: CarrierSystem) async throws -> Carriers
}

final class CarriersService: CarriersServiceProtocol {
    
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    // Информация о перевозчике:
    func getCarrier(code: String, system: CarrierSystem = .yandex) async throws -> Carriers {
        let response = try await client.getCarrier(query: .init(
            apikey: apikey,
            code: code,
            system: system
        ))
        return try response.ok.body.json
    }
}
