//
//  StationViewModel.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 05.05.2025.
//

import SwiftUI

@MainActor
final class StationViewModel: ObservableObject {
    enum State: Equatable {
        case loading, loaded
    }

    @Published var searchString = String()
    @Published private(set) var state: State = .loading

    var filteredStations: [Station] {
        searchString.isEmpty
            ? stations
            : stations.filter { $0.title.lowercased().contains(searchString.lowercased()) }
    }

    private var store: [Components.Schemas.Settlements]
    private var city: City
    private var stations: [Station]

    init(
        store: [Components.Schemas.Settlements],
        city: City,
        stations: [Station] = []
    ) {
        self.store = store
        self.city = city
        self.stations = stations
    }

    func fetchStations() async throws {
        state = .loading
        var convertedStations: [Station] = []
        store.forEach {
            if $0.codes?.yandex_code == city.yandexCode {
                $0.stations?.forEach { settlementStation in
                    guard let station = convert(from: settlementStation) else { return }
                    convertedStations.append(station)
                }
            }
        }
        stations = sortByType(for: convertedStations)
        state = .loaded
    }
}

private extension StationViewModel {
    func sortByType(for stations: [Station]) -> [Station] {
        let sortedStations = stations.sorted { $0.title < $1.title }
        var customSortedStations = sortedStations.filter { $0.type == "airport" }
        customSortedStations += sortedStations.filter { $0.type == "train_station" }
        customSortedStations += sortedStations.filter { $0.type == "marine_station" }
        customSortedStations += sortedStations.filter { $0.type == "river_port" }
        customSortedStations += sortedStations.filter { $0.type == "bus_station" }
        let customSet = Set(customSortedStations.map { $0.id })
        let otherSortedStations = sortedStations.filter { !customSet.contains($0.id) }
        return customSortedStations + otherSortedStations
    }

    func convert(from station: Components.Schemas.SettlementsStation) -> Station? {
        guard
            let type = station.station_type,
            let titleRawValue = station.title,
            let code = station.codes?.yandex_code,
            let longitudeRawValue = station.longitude,
            let latitudeRawValue = station.latitude else { return nil }
        let latitude = extract(latitude: latitudeRawValue)
        let longitude = extract(longitude: longitudeRawValue)
        if latitude == 0 && longitude == 0 { return nil }
        return Station(
            title: type == "airport" ? ["Аэропорт", titleRawValue].joined(separator: " ") : titleRawValue,
            type: type,
            code: code,
            latitude: latitude,
            longitude: longitude
        )
    }

    func extract(longitude: Components.Schemas.SettlementsStation.longitudePayload) -> Double {
        var coordinate: Double = 0
        switch longitude {
            case .case1(let doubleValue): coordinate = doubleValue
            case .case2: break
        }
        return coordinate
    }

    func extract(latitude: Components.Schemas.SettlementsStation.latitudePayload) -> Double {
        var coordinate: Double = 0
        switch latitude {
            case .case1(let doubleValue): coordinate = doubleValue
            case .case2: break
        }
        return coordinate
    }
}

