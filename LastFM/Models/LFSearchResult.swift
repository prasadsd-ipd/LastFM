//
//  LFSearchResult.swift
//  LastFM
//
//  Created by Durga Prasad, Sidde (623-Extern) on 05/09/20.
//  Copyright © 2020 SDP. All rights reserved.
//

import Foundation

// MARK: - LFAlbumSearchResult
struct AlbumSearchResponse: Codable {
    let results: Results
}

// MARK: - Results
struct Results: Codable {
    let opensearchQuery: OpensearchQuery
    let opensearchTotalResults, opensearchStartIndex, opensearchItemsPerPage: String
    let albummatches: AlbumMatches
    let attr: Attr

    enum CodingKeys: String, CodingKey {
        case opensearchQuery = "opensearch:Query"
        case opensearchTotalResults = "opensearch:totalResults"
        case opensearchStartIndex = "opensearch:startIndex"
        case opensearchItemsPerPage = "opensearch:itemsPerPage"
        case albummatches
        case attr = "@attr"
    }
}

// MARK: - AlbumMatches
struct AlbumMatches: Codable {
    let albums: [Album]
    
    enum CodingKeys: String, CodingKey {
        case albums = "album"
    }
}

// MARK: - Album
struct Album: Codable {
    let name, artist: String
    let url: String
    let image: [Image]
    let streamable, mbid: String
}

// MARK: - Image
struct Image: Codable {
    let text: String
    let size: String

    enum CodingKeys: String, CodingKey {
        case text = "#text"
        case size
    }
}

// MARK: - Attr
struct Attr: Codable {
    let attrFor: String

    enum CodingKeys: String, CodingKey {
        case attrFor = "for"
    }
}

// MARK: - OpensearchQuery
struct OpensearchQuery: Codable {
    let text, role, searchTerms, startPage: String

    enum CodingKeys: String, CodingKey {
        case text = "#text"
        case role, searchTerms, startPage
    }
}
