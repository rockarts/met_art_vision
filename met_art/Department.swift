//
//  Department.swift
//  met_art
//
//  Created by Steven Rockarts on 2024-03-22.
//

import Foundation

struct DepartmentsData: Decodable {
    let departments: [Department]
}

struct Department: Codable, Identifiable, Hashable {
    var id: Int
    var displayName: String
    
    enum CodingKeys: String, CodingKey {
        case id = "departmentId"
        case displayName = "displayName"
    }
}


