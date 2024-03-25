//
//  ArtListView.swift
//  met_art
//
//  Created by Steven Rockarts on 2024-03-23.
//

import Foundation

import SwiftUI

struct ArtListView: View {
    var departmentId:Int
    let artListViewModel = ArtListViewModel()
    @State private var artworkId: Set<Artwork.ID> = []
    var body: some View {
        
        List(artListViewModel.artworks, selection: $artworkId) { art in
            Text("\(art.title)")
                .font(.title)
            AsyncImageView(artwork: art)
        }.task {
            do
            {
                try await artListViewModel.fetchObjectsBy(departmentId)
            } catch {
                print(error)
            }
        }
    }
}
