//
//  GitubEndpointTests.swift
//  iOS-TemplateTests
//
//  Created by Apple on 20/10/21.
//

import XCTest
@testable import iOS_Template

class GitubEndpointTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testUserSearchURLGeneration() {
        let endPoint = GithubEndpoint.user(searchText: "sandesh", page: 1)
        XCTAssertEqual(endPoint.scheme, "https")
        XCTAssertEqual(endPoint.baseURL, "api.github.com")
        XCTAssertEqual(endPoint.path, "/search/users")
    }
    
    func testRepoSearchURLGeneration() {
        let endPoint = GithubEndpoint.repos(username: "sandesh")
        XCTAssertEqual(endPoint.scheme, "https")
        XCTAssertEqual(endPoint.baseURL, "api.github.com")
        XCTAssertEqual(endPoint.path, "/users/sandesh/repos")
    }
}
