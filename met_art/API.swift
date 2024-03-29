//
//  API.swift
//  met_art
//
//  Created by Steven Rockarts on 2024-03-24.
//

import Foundation
import Combine

struct API {
  
  /// API Errors.
  enum Error: LocalizedError {
    case addressUnreachable(URL)
    case invalidResponse
    
    var errorDescription: String? {
      switch self {
      case .invalidResponse: return "The server responded with garbage."
      case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable."
      }
    }
  }
    
    enum MetEndPoint {
        static let baseURL = URL(string: "https://collectionapi.metmuseum.org/public/collection/v1/")!
        case departments
        case objectList(Int)
        case object(Int)
        
        var url: URL {
          switch self {
          case .departments:
              return MetEndPoint.baseURL.appendingPathComponent("departments")
          case .objectList(let departmentId):
              return MetEndPoint.baseURL.appendingPathComponent("departments/\(departmentId)")
          case .object(let id):
            return MetEndPoint.baseURL.appendingPathComponent("objects/\(id)")
          }
        }
    }
  

  /// Maximum number of stories to fetch (reduce for lower API strain during development).
  var maxStories = 10

  /// A shared JSON decoder to use in calls.
  private let decoder = JSONDecoder()

    //Create a custom dispatch queue to parse json on a background thread.
    private let apiQueue = DispatchQueue(label: "API", qos: .default, attributes: .concurrent)
  
//  // Add your API code here.
//  func story(id: Int) -> AnyPublisher<Story, Error> {
//    URLSession.shared.dataTaskPublisher(for: EndPoint.story(id).url)
//      .receive(on: apiQueue)
//      .map { $0.0 }
//      .decode(type: Story.self, decoder: decoder)
//      .catch { _ in Empty() }
//      .eraseToAnyPublisher()
//  }
//  
//  func mergedStories(ids storyIDs: [Int]) -> AnyPublisher<Story, Error> {
//    let storyIDs = Array(storyIDs.prefix(maxStories))
//    
//    precondition(!storyIDs.isEmpty)
//
//    let initialPublisher = story(id: storyIDs[0])
//    let remainder = Array(storyIDs.dropFirst())
//    
//    return remainder.reduce(initialPublisher) { (combined, id) -> AnyPublisher<Story, Error> in
//      return combined.merge(with: story(id: id))
//        .eraseToAnyPublisher()
//    }
//  }
//  
//  func stories() -> AnyPublisher<[Story], Error> {
//    URLSession.shared.dataTaskPublisher(for: EndPoint.stories.url)
//      .map { $0.0 }
//      .decode(type: [Int].self, decoder: decoder)
//      .mapError { error in
//        switch error {
//        case is URLError:
//          return Error.addressUnreachable(EndPoint.stories.url)
//        default: return Error.invalidResponse
//        }
//      }
//      .filter { !$0.isEmpty }
//      .flatMap { storyIDs in
//        return self.mergedStories(ids: storyIDs)
//      }
//      .scan([], { (stories, story) -> [Story] in
//        return stories + [story]
//      })
//      .map { stories in
//        return stories.sorted()
//      }
//      .eraseToAnyPublisher()
//  }
}
