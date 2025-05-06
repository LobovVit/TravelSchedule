//
//  SplashView.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 04.04.2025.
//

import SwiftUI

struct SplashView: View {
    
    @State private var darkMode = false
    @StateObject private var scheduleViewModel = ScheduleViewModel()
    @StateObject private var storiesViewModel = StoriesViewModel()
    
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
                            try? await storiesViewModel.loadStories()
                        }
                    }
            case .loaded:
                MainTabView(darkMode: $darkMode,
                            scheduleViewModel: scheduleViewModel,
                            storiesViewModel: storiesViewModel)
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
