//
//  Cities.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 07.04.2025.
//

import Foundation

struct City: Hashable, Identifiable, Sendable {
    let id = UUID()
    let title: String
    let yandexCode: String
    let stationsCount: Int
}
