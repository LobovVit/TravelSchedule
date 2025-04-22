//
//  StoriesView.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 21.04.2025.
//

import SwiftUI

struct StoriesView: View {
    
    private let almostZero = 0.01
    private let full = 1.0
    private let firstStoryIndex = 0
    private let firstPage = 0
    
    private var lastStoryIndex: Int { stories.count - 1 }
    private var storiesCount: Int { stories.count }
    private var lastPage: Int { storiesCount - 1 }
    
    @State private var timer: Timer?
    private let timerInterval = 0.05
    private let progressStep = 0.01
    
    @State var currentProgress: CGFloat = 0
    
    @Binding var stories: [Story]
    @Binding var currentStory: Int
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Color.ypBlack
            .ignoresSafeArea()
            .overlay {
                ZStack(alignment: .topTrailing) {
                    StoriesTabView(stories: $stories, currentStory: $currentStory)
                    
                    ProgressBarView(
                        storiesCount: storiesCount,
                        currentStory: $currentStory,
                        progress: $currentProgress
                    )
                    
                    CloseButtonView {
                        handleDismiss()
                    }
                    .padding(.top, 57.0)
                    .padding(.trailing, 8.0)
                }
                .onTapGesture { location in
                    didTapStoryPage(at: location)
                }
                .gesture(
                    DragGesture()
                        .onEnded { gesture in
                            didSwipeDown(gesture: gesture)
                        }
                )
                .onAppear {
                    startTimer()
                    markStoryAsShown()
                }
                .onDisappear {
                    stopTimer()
                }
                .onChange(of: currentStory) { _ in
                    resetProgress()
                    markStoryAsShown()
                }
            }
    }
}

private extension StoriesView {
    
    func didTapStoryPage(at location: CGPoint) {
        stories[currentStory].isShowed = true
        let halfScreen = UIScreen.main.bounds.width / 2
        switch (currentStory, location.x) {
        case (firstPage, ...halfScreen):
            showPrevious()
        case (lastPage, halfScreen...):
            showNext()
        default:
            withAnimation {
                currentStory = location.x < halfScreen
                ? max(currentStory - 1, 0)
                : min(currentStory + 1, storiesCount - 1)
            }
        }
    }
    
    func didSwipeDown(gesture: DragGesture.Value) {
        switch (gesture.translation.width, gesture.translation.height) {
        case (-30...30, 0...): handleDismiss()
        default: break
        }
    }
    
    func handleDismiss() {
        dismiss()
    }
    
    func showNext() {
        if currentStory == lastStoryIndex {
            withAnimation { currentStory = firstPage }
        } else {
            withAnimation { currentStory += 1 }
        }
    }
    
    func showPrevious() {
        if currentStory > firstPage {
            withAnimation { currentStory -= 1 }
        } else {
            withAnimation { currentStory = lastStoryIndex }
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            if currentProgress < 1.0 {
                withAnimation(.linear(duration: 0.05)) {
                    currentProgress += 0.01
                }
            } else {
                moveToNextStory()
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func resetProgress() {
        currentProgress = 0.0
        stories[currentStory].isShowed = true
    }
    
    func moveToNextStory() {
        if currentStory < lastStoryIndex {
            withAnimation {
                currentStory += 1
                currentProgress = 0.0
                stories[currentStory].isShowed = true
            }
        } else {
            handleDismiss()
        }
    }
    
    private func markStoryAsShown() {
        stories[currentStory].isShowed = true
    }
}

#Preview {
    StoriesView(stories: .constant(Mock.storiesSampleData), currentStory: .constant(1))
}

