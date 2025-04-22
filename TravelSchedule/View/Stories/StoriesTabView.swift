//
//  StoriesTabView.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 21.04.2025.
//

import SwiftUI

struct StoriesTabView: View {
    
    @Binding var stories: [Story]
    @Binding var currentStory: Int
    
    var body: some View {
        TabView(selection: $currentStory) {
            ForEach(Array(stories.enumerated()), id: \.offset) { pageIndex, page in
                StoryFullItemView(model: page)
                    .tag(pageIndex)
            }
        }
        .ignoresSafeArea()
        .tabViewStyle(.page(indexDisplayMode: .never))
        .onChange(of: currentStory) { _ in
                    stories[currentStory].isShowed = true
                }
    }
}

#Preview {
    StoriesTabView(
        stories: .constant(Mock.storiesSampleData),
        currentStory: .constant(0)
    )
}

