//
//  Cities.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 07.04.2025.
//

import Foundation

// MARK: - Struct
struct City: Hashable, Identifiable {
    let id = UUID()
    let title: String
}

// MARK: - Mock data
extension City {
    static let sampleData = [
        City(title: "Москва"),
        City(title: "Санкт-Петербург"),
        City(title: "Сочи"),
        City(title: "Горный Воздух"),
        City(title: "Краснодар")
    ]
}
