//
//  ProgressBarView.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 21.04.2025.
//

import SwiftUI
import Combine

struct ProgressBarView: View {
    let storiesCount: Int
    @Binding var currentStory: Int
    @Binding var progress: CGFloat
    
    private let backgroundColor = Color.ypWhite.opacity(0.3)
    private let accentColor = Color.ypBlue
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 5.0) {
                ForEach(0..<storiesCount, id: \.self) { index in
                    ProgressSegment(
                        progress: index == currentStory ? progress : (index < currentStory ? 1.0 : 0.0),
                        backgroundColor: backgroundColor,
                        accentColor: accentColor
                    )
                }
            }
            .frame(height: 3.0)
        }
        .padding(.top, 35.0)
        .padding(.horizontal, 8.0)
    }
}

private struct ProgressSegment: View {
    let progress: CGFloat
    let backgroundColor: Color
    let accentColor: Color
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(backgroundColor)
                
                Rectangle()
                    .foregroundColor(accentColor)
                    .frame(width: geometry.size.width * progress)
            }
            .cornerRadius(1.5)
        }
    }
}

#Preview {
    ProgressBarView(
        storiesCount: 5,
        currentStory: .constant(2),
        progress: .constant(0.7)
    )
}
