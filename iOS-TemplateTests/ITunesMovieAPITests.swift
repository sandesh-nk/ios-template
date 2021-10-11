//
//  ITunesMovieAPITests.swift
//  iOS-TemplateTests
//
//  Created by Apple on 11/10/21.
//

import XCTest
@testable import iOS_Template
class ITunesMovieAPITests: XCTestCase {
    let timeInterval: TimeInterval = 2
    
    func testITunesMovieSearchURLGeneration() {
        let api = ITunesMovieAPI()
        let endpoint = api.generateURL(for: "Iron man")
        XCTAssertNotNil(endpoint)
        XCTAssertEqual(endpoint!.query, "term=Iron+man&media=movie")
        XCTAssertEqual(endpoint!.absoluteString, "https://itunes.apple.com/search?term=Iron+man&media=movie")
    }

    func testITuneMovieSearch() {
        let expectation = XCTestExpectation()
        let api = ITunesMovieMockAPI()
        api.searchMovie(query: "Avengers"){ (result) in
            switch result {
            case .success(let model):
                expectation.fulfill()
                XCTAssertEqual(model.resultCount, 4)
                XCTAssertGreaterThanOrEqual(model.results.count, 1)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: timeInterval)
    }
}
