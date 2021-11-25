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
    let disposeBag = DisposeBag()
    
    func testSearchStringChanged() {
        let expectation = XCTestExpectation()
        let viewModel = HomeViewModel(iTuneSongAPI: ITuneSongsAPI(ITunesSongAPIMockConfigs.basicConfig))
        viewModel.searchStringChanged(newString: "monster") { _ in }
        
        viewModel.model.subscribe { iTuneModel in
            expectation.fulfill()
            XCTAssertEqual(iTuneModel.count, 1)
            XCTFail("Testing failure")
        } onError: { error in
            XCTFail("Error: \(error)")
        }
        .disposed(by: disposeBag)

        wait(for: [expectation], timeout: timeInterval)
    }
}
