//
//  Route.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 07.04.2025.
//

import Foundation

struct Route: Hashable, Identifiable {
    let id = UUID()
    let date: String
    let departureTime: String
    let arrivalTime: String
    let durationTime: String
    let connectionStation: String
    var isDirect: Bool {
        connectionStation.isEmpty
    }
    let carrierID: UUID
}
