//
//  LFSearchRequest.swift
//  LastFM
//
//  Created by Durga Prasad, Sidde (623-Extern) on 05/09/20.
//  Copyright © 2020 SDP. All rights reserved.
//

import Foundation

struct AlbumSearchRequest {

    // MARK: - Properties

    let baseUrl: String

    // MARK: -

    let album: String

    // MARK: -

    var url: URL? {
        
        var urlComponents = URLComponents(string:baseUrl)!
        
        urlComponents.queryItems = [
            URLQueryItem(name: AlbumSearchService.method, value: AlbumSearchService.albumSearch),
            URLQueryItem(name: AlbumSearchService.album, value: album),
            URLQueryItem(name: AlbumSearchService.apiKey, value: AlbumSearchService.apiKeyValue),
            URLQueryItem(name: AlbumSearchService.format, value: AlbumSearchService.json)
        ]
        return urlComponents.url
    }

}
