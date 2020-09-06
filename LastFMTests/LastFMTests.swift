//
//  LastFMTests.swift
//  LastFMTests
//
//  Created by Durga Prasad, Sidde (623-Extern) on 06/09/20.
//  Copyright © 2020 SDP. All rights reserved.
//

import XCTest
@testable import LastFM

class LastFMTests: XCTestCase {

    let viewModel = VCViewModel()
    
    override func setUpWithError() throws {
        
        let data = loadStub(name: "albums.json", extension: "")
        
        let decoder = JSONDecoder()

        let searchResults = try! decoder.decode(AlbumSearchResponse.self, from: data)

        viewModel.albumsSearchResult = searchResults
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNumberOfMovies() {
        XCTAssertEqual(viewModel.numberOfAlbums, 30)
    }
    
    func testViewModelForIndex() {
        let cellViewModel = viewModel.viewModel(for: 3)
        
        XCTAssertEqual(cellViewModel.name, "Believe")
        XCTAssertEqual(cellViewModel.artist, "Justin Bieber")
    }
}
