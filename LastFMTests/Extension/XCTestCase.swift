//
//  XCTestCase.swift
//  LastFMTests
//
//  Created by Durga Prasad, Sidde (623-Extern) on 06/09/20.
//  Copyright © 2020 SDP. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    func loadStub(name: String, withExten: String) -> Data {
//        let bundle = Bundle(for: classForCoder)
//        let url = bundle.url(forResource: name, withExtension: `extension`)
        let bundle = Bundle.main
        let url = bundle.url(forResource: name, withExtension: withExten)
        return try! Data(contentsOf: url!)
    }
}
