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

class ArtListViewModel: ObservableObject {

    var urlSession = URLSession.shared
    private let decoder = JSONDecoder()
    
    private var subscriptions = Set<AnyCancellable>()
    var error: API.Error?
    
    var object: ObjectList?
    
    @Published var artworks: [Artwork] = []
    var objectList: ObjectList?
    
    let test = [36722, 36723, 36724, 36725, 36726, 36727, 36728, 36729, 36730, 36731, 36732, 36733, 36734, 36735, 36736, 36737, 36738, 36739, 36740, 36741, 36742, 36743, 36744, 36745, 36746, 36747, 36748, 36749, 36750, 36751, 36752, 36753, 36754, 36755, 36756, 36757, 36758, 36759, 36760, 36761, 36762, 36763, 36764, 36765, 36766, 36767, 36768]
    
    private let apiQueue = DispatchQueue(label: "API", qos: .default, attributes: .concurrent)
    @Published var combinedValues: [Int] = [] // Replace 'Int' with your data type
    
    

    // Simulate a function providing new values over time
    func fetchNewValue() -> AnyPublisher<Int, Never> {
        return Future<Int, Never> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // Simulate delay
                let randomValue = Int.random(in: 0...100)
                promise(.success(randomValue))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func fetchValues() {
        fetchNewValue()
            .sink(receiveValue: { newValue in
                self.combinedValues.append(newValue)
                print("Current array:", self.combinedValues)
            })
            .store(in: &subscriptions)

    }
    
    func fetchArtworkByDepartment(id: Int) {
        mergedObjects(ids: test)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print(error.localizedDescription)
                    //self.error = error
                  }
                else {
                    print(completion)
                }
                
            }, receiveValue: { newArtwork in
                print(newArtwork)
                self.artworks.append(newArtwork)  // Append instead of replacing
                self.error = nil
            }).store(in: &subscriptions)
    }
    
    //This is publishing the Artwork Objects. We need a subscriber to sync to it in order to assign the values.
    func mergedObjects(ids objectIds: [Int]) -> AnyPublisher<Artwork, Error> {
        precondition(!objectIds.isEmpty)
        
        let maxObjects = Array(objectIds.prefix(10))
        let initialPublisher = object(id: objectIds[0])
        let remainder = Array(objectIds.dropFirst())
        
        //This is a custom implementation of merge many
        return remainder.reduce(initialPublisher) { combined, id in
            return combined.merge(with: object(id: id))
                .print("ID: \(id)")
                .catch { error in
                        //.print("mergeObjects").catch { error in
                    print("Upstream error caught:", error)
                    return Empty<Artwork, Error>()
                }
                .eraseToAnyPublisher()
        }
    }
    
    func object(id: Int) -> AnyPublisher<Artwork, Error> {
        URLSession.shared.dataTaskPublisher(for: URL(string: "https://collectionapi.metmuseum.org/public/collection/v1/objects/\(id)")!)
            .print("object")
            .receive(on: apiQueue) //Use the backgroud dispatch queue to parse the json.
            .map(\.data) //The dataTaskPublisher(for:) publisher returns an output of type (Data, URLResponse) as a tuple but for your subscription you need only the data
        .decode(type: Artwork.self, decoder: decoder) //Use the Json decoder to decode the returned json into artwork
        .catch { error in
            print("Upstream error caught:", error)
            return Empty<Artwork, Error>()
        }
        .eraseToAnyPublisher()
    }
    
    func fetchObjectsByDepartment(id: Int) -> AnyPublisher<[Artwork], Error> {
        URLSession.shared.dataTaskPublisher(for: URL(string: "https://collectionapi.metmuseum.org/public/collection/v1/objects?departmentIds=6")!)
            .print("fetchObjectsByDepartment")
            .receive(on: apiQueue)
            .map { $0.data }
            .decode(type: ObjectList.self, decoder: decoder)
             .catch { error in
                 print("Upstream error caught:", error)
                 return Empty<ObjectList, Error>()
             }
             .flatMap { objectList in
                 return self.mergedObjects(ids: objectList.id)
             }
             .scan([], { (artworks, artwork) -> [Artwork] in
                 return artworks + [artwork]
             })
             .eraseToAnyPublisher()
    }
}





