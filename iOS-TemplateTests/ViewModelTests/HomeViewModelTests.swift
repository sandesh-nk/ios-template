//
//  HomeViewModelTests.swift
//  iOS-TemplateTests
//
//  Created by Apple on 22/10/21.
//

import XCTest
 
class HomeViewModelTests: XCTestCase {
    let timeInterval: TimeInterval = 10
    
    func testSearchStringChanged() {
        let expectation = XCTestExpectation()
        URLProtocolMock.requestHandler = { request in
            return (HTTPURLResponse(), SongsTestData.songsSmapleData)
        }
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolMock.self]
        let viewModel = HomeViewModel(iTuneSongAPI: ITuneSongsAPI(configuration))
        viewModel.searchStringChanged(newString: "monster") { result  in
            switch result {
            case .success(let iTuneModel):
                expectation.fulfill()
                XCTAssertEqual(iTuneModel.resultCount, 1)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: timeInterval)
    }
}
