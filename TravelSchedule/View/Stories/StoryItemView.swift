//
//  StoryItemView.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 21.04.2025.
//

import SwiftUI

struct StoryItemView: View {
    
    var story: Story
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(story.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 92.0, height: 150.0)
                .clipShape(RoundedRectangle(cornerRadius: 15.0))
                .opacity(story.isShowed ? 0.5 : 1.0)

            Text(story.title)
                .foregroundColor(.ypWhite)
                .font(.system(size: 12, weight: .regular))
                .padding(.horizontal, 8.0)
                .padding(.bottom, 12.0)
                .lineLimit(3)

            RoundedRectangle(cornerRadius: 15)
                .strokeBorder(
                    .ypBlue,
                    lineWidth: story.isShowed ? .zero : 4.0
                )
        }
        .padding(.zero)
        .frame(width: 92.0, height: 150.0)
        .contentShape(RoundedRectangle(cornerRadius: 15.0))
    }
}

#Preview {
    StoryItemView(story: Mock.storiesSampleData[0])
}
