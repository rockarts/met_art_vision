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
        if(viewModel.artworks == []) {
            ProgressView()
        } else {
            List(viewModel.artworks, id: \.objectID) { artwork in
                ArtworkRow(artwork: artwork)
            }
            .navigationTitle("\(department.displayName) Artworks")
        }
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
        VStack(alignment: .center) {
            Text(artwork.title).font(.extraLargeTitle)                .padding()
            HStack {
                Spacer()
                AsyncImageView(artwork: artwork)
                Spacer()
            }
        }
    }
}

#Preview {
    ArtworkListView(department: .example)
}
