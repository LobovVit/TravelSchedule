//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 16.03.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Button("getNearestStations") {
                APIClient.shared.nearestStations()
            }
            Button("getSearch") {
                APIClient.shared.search()
            }
            Button("getSchedules") {
                APIClient.shared.schedules()
            }
            Button("getThread") {
                APIClient.shared.threads()
            }
            Button("getNearestSettlement") {
                APIClient.shared.nearestSettlement()
            }
            Button("getCarrier") {
                APIClient.shared.carriers()
            }
            Button("getStationsList") {
                APIClient.shared.stationsList()
            }
            Button("getCopyright") {
                APIClient.shared.copyright()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
