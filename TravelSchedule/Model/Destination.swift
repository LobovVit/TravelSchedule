//
//  Destination.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 07.04.2025.
//

import Foundation

// MARK: - Struct
struct Destination: Hashable, Identifiable {
    let id = UUID()
    var cityTitle: String = ""
    var stationTitle: String = ""
}

// MARK: - Mock data
extension Destination {
    static var emptyDestination = [Destination(), Destination()]

    static let sampleData: [Destination] = [
        Destination(cityTitle: "Москва", stationTitle: "Ярославский Вокзал"),
        Destination(cityTitle: "Санкт-Петербург", stationTitle: "Балтийский вокзал")
    ]
}
