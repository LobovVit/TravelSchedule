//
//  String.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 06.05.2025.
//
import Foundation

extension String {
    
    var getLocalizedShortDate: String {
        let apiDateFormatter = DateFormatter()
        apiDateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = apiDateFormatter.date(from: self) else { return "ERR date format" }

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd MMMM"
        return dateFormatter.string(from: date)
    }
    
    var returnTimeString: String {
        String(suffix(14).prefix(5))
    }
}
