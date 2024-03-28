//
//  NetworkService.swift
//  met_art
//
//  Created by Steven Rockarts on 2024-03-26.
//

import Combine
import Foundation

class NetworkService {
    private let baseURL = "https://collectionapi.metmuseum.org/public/collection/v1"

    func fetchObjectList(departmentIds: Int) -> AnyPublisher<ObjectList, Error> {
        let url = URL(string: "\(baseURL)/objects?departmentIds=\(departmentIds)")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ObjectList.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func fetchArtwork(objectId: Int) -> AnyPublisher<Artwork, Error> {
        let url = URL(string: "\(baseURL)/objects/\(objectId)")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Artwork.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
