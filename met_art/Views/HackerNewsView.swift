//
//  HackerNewsView.swift
//  met_art
//
//  Created by Steven Rockarts on 2024-03-24.
//

import SwiftUI

struct HackerNewsView: View {
    @ObservedObject var viewModel = HackerNewsViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.stories) { story in
                Text(story.title)
            }
            .navigationTitle("Hacker News")
            .overlay(
                Group {
                    if viewModel.isLoading { ProgressView() }
                }
            )
//            .alert(item: $viewModel.error) { error in
//                Alert(title: Text("Error"), message: Text(error.localizedDescription))
//            }
        }
    }
}

#Preview {
    HackerNewsView()
}
