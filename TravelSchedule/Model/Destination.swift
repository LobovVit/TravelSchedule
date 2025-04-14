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

extension Destination {
    static var emptyDestination = [Destination(), Destination()]
}
