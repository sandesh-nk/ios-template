//
//  ITunesHomeViewModelTests.swift
//  iOS-TemplateTests
//
//  Created by Apple on 12/10/21.
//

import XCTest
@testable import iOS_Template

class ITunesHomeViewModelTests: XCTestCase {
    let timeout: TimeInterval = 2
    
    func testITuneMovies() {
        let expectation = XCTestExpectation()
        let viewModel = ITunesHomeViewModel()
        viewModel.iTunesMovieAPI = ITunesMovieMockAPI()
        XCTAssertEqual(viewModel.model.count, 0)
        viewModel.searchStringChanged(newString: "Avengers") { results in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeout)
        XCTAssertGreaterThanOrEqual(viewModel.model.count, 4)
    }
    
    
}
