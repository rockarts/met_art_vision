//
//  HackerNewsViewModel.swift
//  met_art
//
//  Created by Steven Rockarts on 2024-03-24.
//

import Foundation
import Combine

class HackerNewsViewModel: ObservableObject {
    @Published var stories: [Story] = []
    @Published var isLoading = false
    @Published var error: Error? = nil

    private let api = API()

    init() {
        fetchStories()
    }

    func fetchStories() {
        isLoading = true
        error = nil
        api.stories()
            .receive(on: DispatchQueue.main) // Update UI on the main thread
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.error = error
                case .finished: break
                }
            }, receiveValue: { [weak self] stories in
                self?.stories = stories
            })
    }
}
