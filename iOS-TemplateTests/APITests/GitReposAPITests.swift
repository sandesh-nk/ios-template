//
//  GitReposAPITests.swift
//  iOS-TemplateTests
//
//  Created by Apple on 11/10/21.


import XCTest
@testable import iOS_Template

class GitReposAPITests: XCTestCase {
    let timeInterval: TimeInterval = 10

    func testGitRepoSearch() {
        let expectation = XCTestExpectation()
        
        let testModel = "[{\"name\":\"calculator-x\"},{\"name\":\"Animations\"},{\"name\":\"insta-fan\"},{\"name\":\"YouTube-Clone\"}]"
        let data = Data(testModel.utf8)
        URLProtocolMock.requestHandler = { request in
            return (HTTPURLResponse(), data)
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolMock.self]
        let api = GitReposAPI(configuration)
        api.getRepos(of: "sandesh") { (result) in
            switch result {
            case .success(let repos):
                expectation.fulfill()
                XCTAssertGreaterThanOrEqual(repos.count, 4)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: timeInterval)
    }
}
