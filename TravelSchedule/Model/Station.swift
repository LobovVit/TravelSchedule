//
//  Station.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 07.04.2025.
//

import Foundation

// MARK: - Struct
struct Station: Hashable, Identifiable {
    let id = UUID()
    let title: String
}

// MARK: - Mock data
extension Station {
    static let sampleData = [
        Station(title: "Киевский вокзал"),
        Station(title: "Курский вокзал"),
        Station(title: "Ярославский вокзал"),
        Station(title: "Белорусский вокзал"),
        Station(title: "Савеловский вокзал"),
        Station(title: "Ленинградский вокзал")
    ]
}

