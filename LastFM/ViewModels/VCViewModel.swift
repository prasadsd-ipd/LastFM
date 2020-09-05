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
    
    // MARK: - Initialization
    
    init() {
        // Fetch  Data
        fetchAlbumsData()
    }
    
    // MARK: - Helper Methods
    
    
    private func fetchAlbumsData() {
        
        
        //Initialize Music search request
        let musicSearchrequest = AlbumSearchRequest(baseUrl: AlbumSearchService.baseUrlString, album: "Taylor")
        
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