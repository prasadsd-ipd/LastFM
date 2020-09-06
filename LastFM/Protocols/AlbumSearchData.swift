//
//  AlbumSearchData.swift
//  LastFM
//
//  Created by Durga Prasad, Sidde (623-Extern) on 05/09/20.
//  Copyright © 2020 SDP. All rights reserved.
//

import Foundation

protocol AlbumSearchData {
    
    var results: Results { get }
}

protocol AlbumResult {
    
    var opensearchQuery: Query { get }
    var opensearchTotalResults: String { get }
    var opensearchStartIndex: String { get }
    var opensearchItemsPerPage: String { get }
    var albumMatch:AlbumMatch { get }
    var attribute:ForQuery { get }
}

protocol Query {
    
    var text:String { get }
    var role:String { get }
    var searchTerms:String { get }
    var startPage:String { get }
}

protocol ForQuery {
    
    var forKey:String { get }
    
}

protocol AlbumMatch {
    
    var albums: [AlbumPresentable] { get }
    
}

protocol AlbumPresentable {
    
    var name:String { get }
    var artist:String { get }
    var albumImage:String { get }
}

protocol AlbumImages {
    
    var text:String { get }
    var size:String { get }
}
