//
//  VCViewModel.swift
//  LastFM
//
//  Created by Durga Prasad, Sidde (623-Extern) on 05/09/20.
//  Copyright © 2020 SDP. All rights reserved.
//

import Foundation

class VCViewModel {
    
    // MARK: - Types
    
    enum AlbumFetchErrors: Error {
        case noDataAvailable
    }
    
    // MARK: - Type Aliases
    
    typealias DidFetchDataCompletion = (AlbumSearchData?, AlbumFetchErrors?) -> Void
    
    // MARK: - Properties
    
    var didFetchData: DidFetchDataCompletion?
    
    var albumsSearchResult: AlbumSearchData!
    
    var numberOfAlbums: Int {
        return albumsSearchResult?.results.albummatches.albums.count ?? 0
    }
    
    // MARK: - Methods
    
    func cellViewModel(for index: Int) -> TablecellViewModel {
        return TablecellViewModel(album: albumsSearchResult.results.albummatches.albums[index])
    }
    // MARK: - Initialization
    
    init() {
        // Fetch  Data
        searchAlbums()
    }
    
    // MARK: - Helper Methods
    
    
    func searchAlbums(with key: String = "Taylor") {
        
        //Initialize Music search request
        let musicSearchrequest = AlbumSearchRequest(baseUrl: AlbumSearchService.baseUrlString, album: key)
        
        guard let baseUrl = musicSearchrequest.url else {
            return
        }
        
        URLSession.shared.dataTask(with: baseUrl) { [weak self](data, response, error) in
            if let response = response as? HTTPURLResponse {
                debugPrint("Status Code: \(response.statusCode)")
            }
            
            if let error = error {
                debugPrint("Unable to Fetch  Data \(error)")
                self?.didFetchData?(nil, .noDataAvailable)
            } else if let data = data {
                // Initialize JSON Decoder
                let decoder = JSONDecoder()
                do {
                    // Decode JSON Response
                    let searchResponse = try decoder.decode(AlbumSearchResponse.self, from: data)
                    self?.albumsSearchResult = searchResponse

                    // Invoke Completion Handler
                    self?.didFetchData?(searchResponse, nil)
                } catch {
                    debugPrint("Unable to Decode JSON Response \(error)")
                    // Invoke Completion Handler
                    self?.didFetchData?(nil, .noDataAvailable)
                }
            } else {
                self?.didFetchData?(nil, nil)
            }
        }.resume()
    }
    
}
