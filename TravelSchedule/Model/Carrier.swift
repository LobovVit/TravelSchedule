//
//  Carrier.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 07.04.2025.
//

import Foundation

struct Carrier: Hashable, Identifiable, Sendable  {
    let id = UUID()
    let code: Int
    let title: String
    let logoUrl: String
    let logoSVGUrl: String
    let placeholder: String
    let email: String
    let phone: String
    let contacts: String
}
