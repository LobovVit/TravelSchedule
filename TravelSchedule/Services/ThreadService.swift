//
//  ThreadService.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 18.03.2025.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias Threads = Components.Schemas.ThreadList

protocol ThreadServiceProtocol {
    func getThread(uid: String) async throws -> Threads
}

final class ThreadService: ThreadServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    // Список станций следования:
    func getThread(uid: String) async throws -> Threads {
        let response = try await client.getThread(query: .init(
            apikey: apikey,
            uid: uid
        ))
        return try response.ok.body.json
    }
}
