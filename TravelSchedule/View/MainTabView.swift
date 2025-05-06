//
//  MainTabView.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 04.04.2025.
//


import SwiftUI

struct MainTabView: View {
    
    @Binding var darkMode: Bool
    @ObservedObject var scheduleViewModel: ScheduleViewModel
    @ObservedObject var storiesViewModel: StoriesViewModel
    
    var body: some View {
        NavigationStack(path: $scheduleViewModel.navPath) {
            TabView {
                SearchTabView(storiesViewModel: storiesViewModel, viewModel: scheduleViewModel)
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
            CityView(scheduleViewModel: scheduleViewModel,
                     viewModel: CityViewModel(store: scheduleViewModel.citiesWithStations)
            )
                .toolbar(.hidden, for: .tabBar)
        case .stationView:
            StationView(scheduleViewModel: scheduleViewModel,
                        viewModel: StationViewModel(store: scheduleViewModel.citiesWithStations,
                                                    city: scheduleViewModel.destinations[scheduleViewModel.direction].city)
            )
                .toolbar(.hidden, for: .tabBar)
        case .routeView:
            RoutesListView(scheduleViewModel: scheduleViewModel)
                .toolbar(.hidden, for: .tabBar)
        }
    }
}

#Preview("Light Mode") {
    MainTabView(darkMode: .constant(false),
                scheduleViewModel: ScheduleViewModel(),
                storiesViewModel: StoriesViewModel()
    )
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    MainTabView(darkMode: .constant(true),
                scheduleViewModel: ScheduleViewModel(),
                storiesViewModel: StoriesViewModel()
    )
        .preferredColorScheme(.dark)
}
