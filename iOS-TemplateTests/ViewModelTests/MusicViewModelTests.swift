//
//  MusicViewModelTests.swift
//  iOS-TemplateTests
//
//  Created by Sandesh on 25/10/21.
//

import XCTest

class MusicViewModelTests: XCTestCase {

    func testMusicPlayBack() {
        let musicViewModel = MusicViewModel(SongsTestData.sampleSongItem)
        musicViewModel.playSong()
        XCTAssertNotNil(musicViewModel.avPlayer)
    }

}
