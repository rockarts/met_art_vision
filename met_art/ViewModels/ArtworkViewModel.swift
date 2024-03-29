//
//  ArtworkViewModel.swift
//  met_art
//
//  Created by Steven Rockarts on 2024-03-26.
//

import SwiftUI
import Combine

@Observable
class ArtworkViewModel: ObservableObject {
    private(set) var artworks: [Artwork] = [] // Private(set) for controlled updates
    private let networkService = NetworkService()
    private var subscriptions = Set<AnyCancellable>()

    func loadJson(id: Int) {
        printBundleContents()
        if let path = Bundle.main.path(forResource: "3", ofType: "json") {
                do {
                    let jsonData = try Data(contentsOf: URL(fileURLWithPath: path))
                    let decoder = JSONDecoder()
                    let artworks = try decoder.decode([Artwork].self, from: jsonData)
                    self.artworks = artworks
                } catch {
                    print("Error processing JSON: \(error)")
                }
            } else {
                print("JSON file not found")
            }
    }
    
    func printBundleContents(atPath path: String = "") {
        let resourceKeys: [URLResourceKey] = [.isDirectoryKey, .nameKey]
        let fileManager = FileManager.default

        guard let enumerator = fileManager.enumerator(at: Bundle.main.bundleURL.appendingPathComponent(path),
                                                      includingPropertiesForKeys: resourceKeys) else {
            print("Failed to create enumerator")
            return
        }

        for case let fileURL as URL in enumerator {
            print(fileURL.absoluteURL)
        }
    }
    
    func fetchArtworks(departmentId: Int) {
        networkService.fetchObjectList(departmentIds: departmentId)
            .flatMap { objectList in
                Publishers.MergeMany(objectList.id.prefix(200)
                    .map { self.networkService.fetchArtwork(objectId: $0) })
            }
            .collect(200)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                 // TODO: Error Handling
            }, receiveValue: { artworks in
                self.artworks.append(contentsOf: artworks)
            })
            .store(in: &subscriptions)
    }
}
