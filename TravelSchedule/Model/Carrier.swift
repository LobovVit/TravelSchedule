//
//  Carrier.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 07.04.2025.
//

import Foundation

struct Carrier: Hashable, Identifiable {
    let id = UUID()
    let title: String
    let logoName: String
    let email: String
    let phone: String
}
