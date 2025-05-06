//
//  SearchTabView.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 11.04.2025.
//

import SwiftUI

struct SearchTabView: View {
    
    @ObservedObject var storiesViewModel: StoriesViewModel
    @ObservedObject var viewModel: ScheduleViewModel
    
    var body: some View {
        VStack(spacing: 0.0) {
            StoriesScrollView(stories: Binding(
                get: { storiesViewModel.stories },
                set: { storiesViewModel.stories = $0 }
            ))
            MainSearchView(scheduleViewModel: viewModel)
            Spacer()
        }
    }
}

#Preview {
    SearchTabView(storiesViewModel: StoriesViewModel(),
                  viewModel: ScheduleViewModel()
    )
}
