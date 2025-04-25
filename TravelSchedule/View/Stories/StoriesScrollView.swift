//
//  StoriesScrollView.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 21.04.2025.
//

import SwiftUI

struct StoriesScrollView: View {
    
    private let rows = [GridItem(.flexible())]

    @Binding var stories: [Story]

    @State private var isStoriesShowing = false
    @State private var currentStory = 0

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, spacing: 12.0) {
                ForEach(Array(stories.enumerated()), id: \.offset) { index, story in
                    StoryItemView(story: story)
                        .onTapGesture {
                            isStoriesShowing = true
                            currentStory = index
                        }
                        .fullScreenCover(isPresented: $isStoriesShowing, onDismiss: didDismiss) {
                            StoriesView(stories: $stories, currentStory: $currentStory)
                        }
                }
            }
            .padding(.horizontal, 15.0)
            .padding(.vertical, 24.0)
        }
        .frame(height: 190.0)
    }
}

private extension StoriesScrollView {
    func didDismiss() {
        isStoriesShowing = false
    }
}

#Preview("Light Mode") {
    StoriesScrollView(stories: .constant(Mock.storiesSampleData))
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    StoriesScrollView(stories: .constant(Mock.storiesSampleData))
        .preferredColorScheme(.dark)
}
