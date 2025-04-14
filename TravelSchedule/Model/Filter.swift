//
//  Filter.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 07.04.2025.
//

import Foundation

struct Filter: Hashable {
    var isWithTransfers = true
    var isAtNight = true
    var isMorning = true
    var isAfternoon = true
    var isEvening = true
}

extension Filter {
    static let fullSearch = Filter()
}

