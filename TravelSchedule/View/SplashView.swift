//
//  SplashView.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 04.04.2025.
//

import SwiftUI

struct SplashView: View {
    
    @State private var isPresented: Bool = false
    @State private var schedule = Mock.schedulesSampleData
    @State private var darkMode = false
    
    var body: some View {
        if isPresented {
            MainTabView(schedule: $schedule, darkMode: $darkMode)
            .environment(\.colorScheme, darkMode ? .dark : .light)
        } else {
            Image("splash", bundle: nil)
                .resizable()
                .ignoresSafeArea()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            self.isPresented = true
                        }
                    }
                }
        }
    }
}

#Preview {
    SplashView()
}
