//
//  ObjectList.swift
//  met_art
//
//  Created by Steven Rockarts on 2024-03-23.
//

import Foundation

class ObjectList: Codable {
    let id: [Int]
    
    enum CodingKeys: String, CodingKey {
        case id = "objectIDs"
    }
}
