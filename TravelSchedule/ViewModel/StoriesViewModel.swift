//
//  StoriesViewModel.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 29.04.2025.
//

import Foundation

@MainActor
class StoriesViewModel: ObservableObject {
    @Published var stories: [Story] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    func loadStories() async {
        isLoading = true
        defer { isLoading = false }

        do {
            // сервис картинок
            stories = Mock.storiesSampleData
        } catch {
            debugPrint("Failed to load stories: \(error.localizedDescription)")
            stories = Mock.storiesSampleData
        }
    }
}
