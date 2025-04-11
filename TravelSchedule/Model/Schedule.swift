//
//  Schedule.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 07.04.2025.
//

import Foundation

// MARK: - Struct
struct Schedules: Hashable, Identifiable {
    let id = UUID()
    let cities: [City]
    let stations: [Station]
    var destinations: [Destination]
    let routes: [Route]
    let carriers: [Carrier]
}

// MARK: - Mock data
extension Schedules {
    static let sampleData = Schedules(
        cities: City.sampleData,
        stations: Station.sampleData,
        destinations: Destination.emptyDestination,
        routes: Route.sampleData,
        carriers: Carrier.sampleData
    )
}

