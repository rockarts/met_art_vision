//
//  ArtListView.swift
//  met_art
//
//  Created by Steven Rockarts on 2024-03-23.
//

import Foundation

import SwiftUI
import Combine

struct ArtListView: View {
    var departmentId:Int
    @ObservedObject var artListViewModel = ArtListViewModel()
    @State private var artworkId: Set<Artwork.ID> = []
    
    
    var body: some View {
        //        List(artListViewModel.artworks , selection: $artworkId) { art in
        //            Text("\(art.title)")
        //                .font(.title)
        //            AsyncImageView(artwork: art)
        //        }
        
        List {
            ForEach(artListViewModel.combinedValues, id: \.self) { value in
                Text("Value \(value)")
                    .font(.title)
                // (Create a custom ArtworkRowView to display artwork details)
            }
        }.task {
            artListViewModel.fetchValues()
        }
        
        List {
            ForEach(artListViewModel.artworks) { art in
                Text("\(art.title)")
                    .font(.title)
                AsyncImageView(artwork: art)
                // (Create a custom ArtworkRowView to display artwork details)
            }
        }
        .task {
            
            //try await artListViewModel.fetchObjectsBy(departmentId)
            artListViewModel.fetchArtworkByDepartment(id: departmentId)
            
            
            //                artListViewModel.object(id: 1074)
            //                    .sink(receiveCompletion: { print($0)}, receiveValue: { print ($0)})
            //                    .store(in: &subscriptions)
            
        }
    }
}
