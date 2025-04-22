//
//  StoryFullItemView.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 21.04.2025.
//

import SwiftUI

struct StoryFullItemView: View {
    
    private enum LineLimits {
        static let title = 2
        static let description = 3
    }
    
    var model: Story
    
    var body: some View {
        Color.ypBlack
        .ignoresSafeArea()
            .overlay {
                ZStack {
                    Image(model.imageName)
                        .resizable()
                        .scaledToFill()
                        .clipShape(RoundedRectangle(cornerRadius: 40.0))
                        .padding(.top, 4.0)
                        .padding(.horizontal, .zero)

                    VStack(alignment: .leading, spacing: 12.0) {
                        Spacer()

                        Text(model.title)
                            .font(.system(size: 34, weight: .bold))
                            .lineLimit(LineLimits.title)

                        Text(model.description)
                            .font(.system(size: 20, weight: .regular))
                            .lineLimit(LineLimits.description)
                    }
                    .foregroundStyle(.ypWhite)
                    .padding(.horizontal, 12.0)
                    .padding(.bottom, 40.0)
                }
                .padding(.bottom, 16.0)
            }
    }
}

#Preview {
    StoryFullItemView(model: Mock.storiesSampleData[0])
}

