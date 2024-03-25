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
    
    var body: some View {
        VStack {
            Text("Art List View \(artListViewModel.artwork?.objectName ?? "")").task {
                try! await artListViewModel.fetchObjectsBy(departmentId)
            }
            AsyncImage(
        }
        
    }
}
