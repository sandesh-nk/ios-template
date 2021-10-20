//
//  GitUserAPITests.swift
//  iOS-TemplateTests
//
//  Created by Apple on 11/10/21.
//

import XCTest
@testable import iOS_Template

class GitUserAPITests: XCTestCase {
    let timeInterval: TimeInterval = 10
        

    func testGitUserSearch() {
        let expectation = XCTestExpectation()
        
        let testModel = "{\"total_count\":5,\"incomplete_results\":false,\"items\":[{\"login\":\"san\"},{\"login\":\"san\"},{\"login\":\"san\"},{\"login\":\"san\"},{\"login\":\"san\"},{\"login\":\"san\"}]}"
        let data = Data(testModel.utf8)
        URLProtocolMock.requestHandler = { request in
            return (HTTPURLResponse(), data)
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolMock.self]
        let api = GitUsersAPI(configuration)
        api.searchUsers(query: "sandesh", page: 1) { (result) in
            switch result {
            case .success(let model):
                expectation.fulfill()
                XCTAssertGreaterThanOrEqual(model.items.count, 6)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: timeInterval)
    }
}
