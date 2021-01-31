//
//  PhotoListTests.swift
//  PhotoListTests
//
//  Created by Jader Nunes on 2021-01-25.
//

import XCTest

class PhotoListTests: XCTestCase {

    func testListPhotos() {
        let expect = expectation(description: #function)
        
        let viewModel = HomeViewModel()
        viewModel.loadPhotos {
            expect.fulfill()
            XCTAssertNotNil(viewModel.photo(0))
        }
        
        waitForExpectations(timeout: 60)
    }
    
    func testNoPhotos() {
        let viewModel = HomeViewModel()
        XCTAssertEqual(viewModel.countPhotos(), 0)
    }
}
