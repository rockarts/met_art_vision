//
//  ArtListViewModel.swift
//  met_art
//
//  Created by Steven Rockarts on 2024-03-23.
//

import Foundation
import Combine


//https://collectionapi.metmuseum.org/public/collection/v1/objects?departmentIds=1
//https://collectionapi.metmuseum.org/public/collection/v1/objects/[objectID]
@Observable
class ArtListViewModel {

    var urlSession = URLSession.shared
    private let decoder = JSONDecoder()
    
    var objects: ObjectList?
    //var artwork: Artwork?
    
    var artworks: [Artwork] = []
    
    func fetchObjectsBy(_ departmentId:Int) async throws  {
        let url = URL(string: "https://collectionapi.metmuseum.org/public/collection/v1/objects?departmentIds=\(departmentId)")!

        let (data, _) = try await urlSession.data(from: url)

        let objectList = try decoder.decode(ObjectList.self, from: data)
        self.objects = objectList
        
        try await withThrowingTaskGroup(of: Artwork.self, body: { taskGroup in
                for objectId in objectList.id.prefix(upTo: 20) {
                    taskGroup.addTask {
                        let artworkUrl = URL(string: "https://collectionapi.metmuseum.org/public/collection/v1/objects/\(objectId)")!
                        let (data, _) = try await self.urlSession.data(from: artworkUrl)
                        return try self.decoder.decode(Artwork.self, from: data)
                    }
                }

                // Collect the results of all the artwork fetches
                var artworks = [Artwork]()
                for try await artwork in taskGroup {
                    artworks.append(artwork)
                }
                //return artworks
            })
//        for objectId in objectList.id.prefix(upTo: 20) {
//            let artworkUrl = URL(string: "https://collectionapi.metmuseum.org/public/collection/v1/objects/\(objectId)")!
//
//            let (data2, _) = try await urlSession.data(from: artworkUrl)
//            print(String(data: data2, encoding: .utf8))
//            
//            let artwork = try decoder.decode(Artwork.self, from: data2)
//
//            self.artworks.append(artwork)
//            
//        }
    }
}





