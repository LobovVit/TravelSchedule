//
//  MainTabView.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 04.04.2025.
//


import SwiftUI

struct MainTabView: View {
    
    @Binding var schedule: Schedules
    @Binding var darkMode: Bool
    @State var navPath: [ViewsRouter] = []
    @State var direction: Int = 0
    
    var body: some View {
        NavigationStack(path: $navPath) {
            TabView {
                SearchTabView(schedule: $schedule, navPath: $navPath, direction: $direction)
                    .tabItem { Image("schedule").renderingMode(.template) }
                SettingsView(darkMode: $darkMode)
                    .tabItem { Image("settings").renderingMode(.template) }
            }
            .accentColor(.ypBlackWhite)
            .toolbar(.visible, for: .tabBar)
            .navigationDestination(for: ViewsRouter.self, destination: destinationView)
        }
    }
    
    @ViewBuilder
    private func destinationView(for pathValue: ViewsRouter) -> some View {
        switch pathValue {
        case .cityView:
            CityView(schedule: $schedule, navPath: $navPath, direction: $direction)
                .toolbar(.hidden, for: .tabBar)
        case .stationView:
            StationView(schedule: $schedule, navPath: $navPath, direction: $direction)
                .toolbar(.hidden, for: .tabBar)
        case .routeView:
            RoutesListView(schedule: $schedule)
                .toolbar(.hidden, for: .tabBar)
        }
    }
}

#Preview("Light Mode") {
    MainTabView(schedule: .constant(Mock.schedulesSampleData), darkMode: .constant(false))
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    MainTabView(schedule: .constant(Mock.schedulesSampleData), darkMode: .constant(true))
        .preferredColorScheme(.dark)
}
