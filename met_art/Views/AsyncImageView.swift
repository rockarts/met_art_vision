//
//  AsyncImageView.swift
//  met_art
//
//  Created by Steven Rockarts on 2024-03-23.
//

import SwiftUI

struct AsyncImageView: View {
    //@State var imageURL:URL
    @State var artwork: Artwork
    
    @Environment(\.openWindow) var openWindow
    
    var body: some View {
        if let url = URL(string: artwork.primaryImage ?? "") {
            AsyncImage(
                url: url){ phase in
                    switch phase {
                    case .success(let image):
                        Button {
                            openWindow(value: artwork)
                        } label: {
                            image
                                .resizable()
                                .scaledToFit()
                                .containerRelativeFrame(.horizontal) { size, axis in
                                    size * 0.3
                                }
                                .clipShape(.rect(cornerRadius: 15))
                        }
                        .buttonStyle(.plain)
                        .buttonBorderShape(.roundedRectangle(radius: 15))
                        
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
                .padding(40)
        }
    }
}
