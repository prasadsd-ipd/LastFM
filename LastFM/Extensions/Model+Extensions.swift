//
//  Model+Extensions.swift
//  LastFM
//
//  Created by Durga Prasad, Sidde (623-Extern) on 05/09/20.
//  Copyright © 2020 SDP. All rights reserved.
//

import Foundation

extension AlbumSearchResponse: AlbumSearchData {}

extension Image: AlbumImages {}

extension Album: AlbumPresentable {
    var albumImage: String {
        return self.image[1].text
    }
}
