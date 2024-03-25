//
//  AsyncImageView.swift
//  met_art
//
//  Created by Steven Rockarts on 2024-03-23.
//

import SwiftUI

struct AsyncImageView: View {
    @State var imageURL:String
    
    var body: some View {
        AsyncImage(
            url: URL(string: imageURL ),
                transaction: Transaction(
                    animation: .spring(
                        response: 0.5,
                        dampingFraction: 0.65,
                        blendDuration: 0.025)
                )
            ){ phase in
                switch phase {
                    case .success(let image):
                        image
                        .resizable().frame(width: 100, height: 100)
                        //.resizable()
                        //.aspectRatio(contentMode: .fill) // Maintain aspect ratio
                       // .frame(width: 20, height: 20)
                        //x.scaledToFit()
                            .transition(.scale)
                        
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
