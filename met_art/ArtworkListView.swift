//
//  ArtworkListView.swift
//  met_art
//
//  Created by Steven Rockarts on 2024-03-26.
//

import SwiftUI

struct ArtworkListView: View {
    var department:Department
    var viewModel = ArtworkViewModel()

    var body: some View {
        List(viewModel.artworks, id: \.objectID) { artwork in
            ArtworkRow(artwork: artwork)
        }
        .navigationTitle("\(department.displayName) Artworks")
//        .task {
//            viewModel.fetchArtworks(departmentId: department.id)
//        }
    }
    
    init(department: Department, viewModel: ArtworkViewModel = ArtworkViewModel()) {
        self.department = department
        self.viewModel = viewModel
        viewModel.fetchArtworks(departmentId: department.id)
    }
}

struct ArtworkRow: View {
    let artwork: Artwork

    var body: some View {
        VStack {
            Text(artwork.title).font(.extraLargeTitle)
            AsyncImageView(artwork: artwork)
        }
    }
}

#Preview {
    ArtworkListView(department: .example)
}
