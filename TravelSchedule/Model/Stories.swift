//
//  Stories.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 21.04.2025.
//

import Foundation

struct Story: Identifiable {
    let id = UUID()
    var imageName: String
    var isShowed: Bool = false
    var title: String
    var description: String
}
