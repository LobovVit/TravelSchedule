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

extension Carrier {
    static let sampleData: [Carrier] = [
        Carrier(title: "РЖД", logoName: "rzhd", email: "qweasd@ya.ru", phone: "+7 (999) 999-99-99"),
        Carrier(title: "ФГК", logoName: "fgk", email: "qqqweasd@ya.ru", phone: "+7 (999) 999-99-99"),
        Carrier(title: "Урал логистика", logoName: "ural", email: "wwwqweasd@ya.ru", phone: "+7 (999) 999-99-9")
    ]
}

