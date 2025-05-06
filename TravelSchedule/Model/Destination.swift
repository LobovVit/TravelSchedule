//
//  Destination.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 07.04.2025.
//

import Foundation

// MARK: - Struct
struct Destination: Hashable, Identifiable, Sendable {
    let id = UUID()
    var city: City
    var station: Station
}

extension Destination {
    static let emptyDestination = [
        Destination(
            city: City(title: "", yandexCode: "", stationsCount: 0),
            station: Station(title: "", type: "", code: "", latitude: 0, longitude: 0)
        ),
        Destination(
            city: City(title: "", yandexCode: "", stationsCount: 0),
            station: Station(title: "", type: "", code: "", latitude: 0, longitude: 0)
        )
    ]
}
