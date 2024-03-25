//
//  met_artApp.swift
//  met_art
//
//  Created by Steven Rockarts on 2024-03-22.
//

import SwiftUI

@main
struct met_artApp: App {
    var body: some Scene {
        WindowGroup {
            DepartmentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
        
        WindowGroup(for: Artwork.self) { $artwork in
            if let artwork {
                if let url = URL(string: artwork.primaryImage ?? "") {
                    AsyncImage(
                        url: url){ phase in
                            switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                
                                case .failure(_):
                                    Image(systemName:  "ant.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.teal)
                                        .opacity(0.6)

                                case .empty:
                                    Image(systemName: "paintpalette")
                                    .resizable().frame(width: 100, height: 100)
                                        .foregroundColor(.teal)
                                        .opacity(0.6)

                                @unknown default:
                                    ProgressView()
                            }
                        }
                }
            }
        }.defaultSize(width: 1000, height: 1000)
        
        WindowGroup(for: String.self) { $string in
            if let string {
                Image(string)
                    .resizable()
                    .scaledToFill()
            }
        }.defaultSize(width: 1000, height: 1000)
    }
}
