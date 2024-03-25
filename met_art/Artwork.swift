//
//  Artwork.swift
//  met_art
//
//  Created by Steven Rockarts on 2024-03-23.
//

import Foundation

struct Artwork: Codable, Hashable, Identifiable {
    var id: UUID? = UUID()
    let objectID: Int
    let isHighlight: Bool
    let accessionNumber: String
    let accessionYear: String
    let isPublicDomain: Bool
    let primaryImage: String?
    let primaryImageSmall: String
    let additionalImages: [String]
    let constituents: [Constituent]?
    let department: String
    let objectName: String
    let title: String
    let culture: String
    let period: String
    let dynasty: String 
    let reign: String 
    let portfolio: String 
    let artistRole: String
    let artistPrefix: String 
    let artistDisplayName: String
    let artistDisplayBio: String
    let artistSuffix: String  
    let artistAlphaSort: String
    let artistNationality: String
    let artistBeginDate: String
    let artistEndDate: String
    let artistGender: String
    let artistWikidata_URL: String
    let artistULAN_URL: String
    let objectDate: String
    let objectBeginDate: Int
    let objectEndDate: Int
    let medium: String
    let dimensions: String
    let measurements: [Measurement]?
    let creditLine: String
    let geographyType: String  
    let city: String  
    let state: String 
    let county: String 
    let country: String 
    let region: String 
    let subregion: String 
    let locale: String  
    let locus: String  
    let excavation: String  
    let river: String  
    let classification: String
    let rightsAndReproduction: String  
    let linkResource: String  
    let metadataDate: String
    let repository: String
    let objectURL: String
    let tags: [Tag]?
    let objectWikidata_URL: String
    let isTimelineWork: Bool
    let GalleryNumber: String 
}

struct Constituent: Codable, Hashable {
    let constituentID: Int
    let role: String
    let name: String
    let constituentULAN_URL: String
    let constituentWikidata_URL: String
    let gender: String
}

struct Measurement: Codable, Hashable {
    let elementName: String
    let elementDescription: String?
    let elementMeasurements: ElementMeasurements
}

struct ElementMeasurements: Codable, Hashable {
    let Height: Double?
    let Width: Double?
}

struct Tag: Codable, Hashable {
    let term: String
    let AAT_URL: String
}
