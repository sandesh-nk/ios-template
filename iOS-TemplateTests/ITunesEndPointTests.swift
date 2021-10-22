//
//  ITunesEndPointTests.swift
//  iOS-TemplateTests
//
//  Created by Apple on 20/10/21.
//

import XCTest
@testable import iOS_Template

class ITunesEndPointTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testURLGeneration() {
        let endpoint = ITunesEndpoint.getSong(searchText: "monster")
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.params
        XCTAssertNotNil(components.url)
        XCTAssertEqual(components.url!.absoluteString, "https://itunes.apple.com/search?term=monster&media=music")
    }
    
    func testSearchTermGeneration() {
        let endpoint = ITunesEndpoint.getSong(searchText: "Am still standing")
        let seachterm = endpoint.params.first!.value
        XCTAssertEqual(seachterm, "Am+still+standing")
    }
}
