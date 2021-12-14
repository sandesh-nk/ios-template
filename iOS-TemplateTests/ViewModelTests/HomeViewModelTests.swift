//
//  HomeViewModelTests.swift
//  iOS-TemplateTests
//
//  Created by Apple on 22/10/21.
//

import XCTest
import RxSwift
 
class HomeViewModelTests: XCTestCase {
    let timeInterval: TimeInterval = 10
    private let disposeBag = DisposeBag()
    func testSearchStringChanged() {
        let expectation = XCTestExpectation()
        URLProtocolMock.requestHandler = { _ in
            return (HTTPURLResponse(), SongsTestData.songsSmapleData)
        }
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolMock.self]
        let viewModel = HomeViewModel(iTuneSongAPI: ITuneSongsAPI(configuration))
        viewModel.searchStringChanged(newString: "monster") {_ in }
        viewModel.model.subscribe { iTuneModel in
            expectation.fulfill()
            XCTAssertEqual(iTuneModel.count, 1)
        } onError: { error in
            XCTFail("Error: \(error)")
        }
        .disposed(by: disposeBag)
        wait(for: [expectation], timeout: timeInterval)
    }
}
