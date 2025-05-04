//
//  Array.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 03.05.2025.
//

extension Array where Element == Components.Schemas.Settlements {
    func toCityWithStations() -> [CityWithStations] {
        self.compactMap { settlement  -> CityWithStations? in
            guard let cityTitle = settlement.title else { return nil }
            let city = City(title: cityTitle, stationsCount: settlement.stations?.count ?? 0)
            let stations: [Station] = (settlement.stations ?? []).compactMap { station in
                guard let title = station.title else { return nil }
                return Station(title: title)
            }
            return CityWithStations(city: city, stations: stations)
        }
    }
}

