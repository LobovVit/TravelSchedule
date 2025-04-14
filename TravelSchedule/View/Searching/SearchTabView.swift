//
//  SearchTabView.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 11.04.2025.
//

import SwiftUI

struct SearchTabView: View {
    
    @Binding var schedule: Schedules
    @Binding var navPath: [ViewsRouter]
    @Binding var direction: Int
    
    var body: some View {
        VStack(spacing: 0.0) {
            MainSearchView(schedule: $schedule, navPath: $navPath, direction: $direction)
            Spacer()
        }
    }
}

#Preview {
    SearchTabView(
        schedule: .constant(Mock.schedulesSampleData),
        navPath: .constant([]),
        direction: .constant(0)
    )
}
