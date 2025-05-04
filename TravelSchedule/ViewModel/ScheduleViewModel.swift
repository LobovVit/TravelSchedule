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

    @Published private(set) var state: State = .loading
    @Published private(set) var currentError: AppErrorType = .serverError
    @Published var navPath: [ViewsRouter] = []
    @Published private(set) var citiesWithStations: [Components.Schemas.Settlements] = []

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
}
