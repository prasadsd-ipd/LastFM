//
//  TableCellViewModel.swift
//  LastFM
//
//  Created by Durga Prasad, Sidde (623-Extern) on 05/09/20.
//  Copyright © 2020 SDP. All rights reserved.
//

import Foundation

struct TablecellViewModel {
    
//MARK: - Properties
    var album: AlbumPresentable
    
    var name: String {
        return album.name
    }
    
    var artist: String {
        return album.artist
    }
}

extension TablecellViewModel: AlbumPresentable {
    var albumImage: String {
        return album.albumImage
    }
}
