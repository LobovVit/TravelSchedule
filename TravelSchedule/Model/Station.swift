//
//  Station.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 07.04.2025.
//

import Foundation

struct Station: Hashable, Identifiable, Sendable {
    let id = UUID()
    let title: String
    let type: String
    let code: String
    let latitude: Double
    let longitude: Double
}
