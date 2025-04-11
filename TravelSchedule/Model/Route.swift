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

extension Route {
    static let sampleData: [Route] = [
        Route(
            date: "14 марта",
            departureTime: "23:33",
            arrivalTime: "08:33",
            durationTime: "20",
            connectionStation: "",
            carrierID: Carrier.sampleData[0].id
        ),
        Route(
            date: "15 марта",
            departureTime: "01:15",
            arrivalTime: "19:00",
            durationTime: "9",
            connectionStation: "Кострома",
            carrierID: Carrier.sampleData[1].id
        ),
        Route(
            date: "16 марта",
            departureTime: "12:30",
            arrivalTime: "21:00",
            durationTime: "9",
            connectionStation: "",
            carrierID: Carrier.sampleData[2].id
        )
    ]
}

