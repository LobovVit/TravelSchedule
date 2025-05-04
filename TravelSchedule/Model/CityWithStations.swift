//
//  CityWithStations.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 03.05.2025.
//

import Foundation

struct CityWithStations: Identifiable, Hashable {
    let id = UUID()
    let city: City
    let stations: [Station]
}
