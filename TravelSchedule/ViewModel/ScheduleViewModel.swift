//
//  SearchViewModel.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 03.05.2025.
//

import SwiftUI
import Foundation

@MainActor
final class ScheduleViewModel: ObservableObject {
    enum State: Equatable {
        case loading, loaded, error
    }
    let dummyDirection = ["Откуда", "Куда"]

    @Published private(set) var state: State = .loading
    @Published private(set) var currentError: AppErrorType = .serverError
    @Published var navPath: [ViewsRouter] = []
    @Published private(set) var citiesWithStations: [Components.Schemas.Settlements] = []
    @Published private(set) var destinations: [Destination]
    @Published private(set) var direction: Int = 0
    
    var isSearchButtonReady: Bool {
        !destinations[0].city.title.isEmpty &&
        !destinations[0].station.title.isEmpty &&
        !destinations[1].city.title.isEmpty &&
        !destinations[1].station.title.isEmpty
    }
    
    init(
        destinations: [Destination] = Destination.emptyDestination
    ) {
        self.destinations = destinations
    }

    func fetchData() async throws  {
            state = .loading
            do {
                citiesWithStations = try await APIClient.shared.fetchStations()
                state = .loaded
            } catch {
                currentError = error.localizedDescription.contains("error 0.") ? .serverError : .noInternet
                state = .error
                throw currentError == .serverError ? AppErrorType.serverError : AppErrorType.noInternet
            }
    }
    
    func swapDestinations() {
        (destinations[0], destinations[1]) = (destinations[1], destinations[0])
    }

    func setDirection(to direction: Int) {
        self.direction = direction
    }

    func saveSelected(city: City) {
        destinations[direction].city = city
    }

    func saveSelected(station: Station) {
        destinations[direction].station = station
    }
}
