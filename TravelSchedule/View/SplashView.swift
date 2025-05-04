//
//  SplashView.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 04.04.2025.
//

import SwiftUI

struct SplashView: View {
    
    @State private var schedule = Mock.schedulesSampleData
    @State private var darkMode = false
    @StateObject private var scheduleViewModel = ScheduleViewModel()
    
    var body: some View {
        Group {
            switch scheduleViewModel.state {
            case .loading:
                Image("splash", bundle: nil)
                    .resizable()
                    .ignoresSafeArea()
                    .onAppear {
                        Task {
                            try? await scheduleViewModel.fetchData()
                        }
                    }
            case .loaded:
                Text("Loaded \(scheduleViewModel.citiesWithStations.count)" )
                MainTabView(schedule: $schedule,
                            darkMode: $darkMode)
                    .environment(\.colorScheme, darkMode ? .dark : .light)
            case .error:
                ErrorView(type: scheduleViewModel.currentError)
            }
        }
    }
}

#Preview {
    SplashView()
}
