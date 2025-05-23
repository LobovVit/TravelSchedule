//
//  Int.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 06.05.2025.
//

import Foundation

extension Int {
    
    var getLocalizedInterval: String {
        let interval = self
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ru_RU")
        let formatter = DateComponentsFormatter()
        formatter.calendar = calendar

        formatter.unitsStyle = .full
        formatter.allowedUnits = interval > 60 * 60 * 24
        ? [.day, .hour]
        : [.hour, .minute]
        return formatter.string(from: TimeInterval(Double(interval))) ?? "today"
    }
}
