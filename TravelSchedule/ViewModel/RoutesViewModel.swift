//
//  RoutesViewModel.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 05.05.2025.
//

import SwiftUI

@MainActor
final class RoutesViewModel: ObservableObject {
    enum State: Equatable {
        case loading, loaded, none, error
    }

    @Published var filter = Filter()
    @Published private(set) var isError: Bool = false

    @Published private(set) var state: State = .loading
    @Published private(set) var carriers: [Carrier] = []
    @Published private(set) var currentError: AppErrorType = .serverError

    @Published private(set) var destinations: [Destination]

    private(set) var routes: [Route]

    var departure: String {
        destinations[0].station.title.contains(destinations[0].city.title)
        ? destinations[0].station.title
        : destinations[0].city.title + " (" + destinations[0].station.title + ")"
    }

    var arrival: String {
        destinations[1].station.title.contains(destinations[1].city.title)
        ? destinations[1].station.title
        : destinations[1].city.title + " (" + destinations[1].station.title + ")"
    }
    
    var filteredRoutes: [Route] {
        let complexRoutes = filter.isWithTransfers
            ? routes
            : routes.filter { $0.isDirect == true }
        var allRoutes = filter.isAtNight
        ? complexRoutes.filter { $0.departureTime.starts(with: /0[0-5]/) }
        : []
        allRoutes += filter.isMorning
        ? complexRoutes.filter { $0.departureTime.starts(with: /0[6-9]/) || $0.departureTime.starts(with: /1[0-1]/) }
        : []
        allRoutes += filter.isAfternoon
        ? complexRoutes.filter { $0.departureTime.starts(with: /1[2-8]/) }
        : []
        allRoutes += filter.isEvening
        ? complexRoutes.filter { $0.departureTime.starts(with: /19/) || $0.departureTime.starts(with: /2[0-4]/) }
        : []
        return allRoutes.sorted { $0.date < $1.date }
    }

    init(
        destinations: [Destination],
        routes: [Route] = [],
    ) {
        self.destinations = destinations
        self.routes = routes
    }

    func searchRoutes() async throws {
        state = .loading
        var segments: [Components.Schemas.Segment] = []
        do {
            segments = try await APIClient.shared.fetchRoutes(
                from: destinations[0].station,
                to: destinations[1].station
            )
        } catch {
            currentError = error.localizedDescription.contains("error 0.") ? .serverError : .noInternet
            state = .error
            throw currentError == .serverError ? AppErrorType.serverError : AppErrorType.noInternet
        }

        var convertedRoutes: [Route] = []
        segments.forEach { segment in
            let hasTransfers = segment.has_transfers ?? false
            if !hasTransfers {
                guard let duration = segment.duration else { return }
                let uid = segment.thread?.uid ?? "ND"
                let type = segment.from?.transport_type ?? .bus
                guard
                    let carrier = segment.thread?.carrier,
                    let carrierCode = carrier.code else { return }

                if carriers.filter({ $0.code == carrierCode }).isEmpty {
                    convert(from: carrier, for: type.rawValue)
                }

                let route = Route(
                    code: uid,
                    date: segment.start_date ?? "today",
                    departureTime: (segment.departure ?? "").returnTimeString,
                    arrivalTime: (segment.arrival ?? "").returnTimeString,
                    durationTime: duration.getLocalizedInterval,
                    connectionStation: String(),
                    carrierCode: carrierCode
                )
                convertedRoutes.append(route)
            }
        }
        routes = convertedRoutes
        state = routes.isEmpty ? .none : .loaded
    }

    func convert(from carrier: Components.Schemas.CarriersItems, for type: String) {
        var placeholder = String()
        switch type {
            case "plane": placeholder = "airplane.circle"
            case "train", "suburban": placeholder = "cablecar"
            case "water": placeholder = "ferry"
            default: placeholder = "bus.fill"
        }
        let convertedCarrier = Carrier(
            code: carrier.code ?? 0,
            title: carrier.title ?? "ND",
            logoUrl: carrier.logo ?? "",
            logoSVGUrl: carrier.logo_svg ?? "",
            placeholder: placeholder,
            email: carrier.email ?? "",
            phone: carrier.phone ?? "",
            contacts: carrier.contacts ?? ""
        )
        if convertedCarrier.code != 0 {
            carriers.append(convertedCarrier)
        }
    }
}

