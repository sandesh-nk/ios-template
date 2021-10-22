//
//  MusicViewModel.swift
//  iOS-Template
//
//  Created by Apple on 22/10/21.
//

import Foundation
import AVFoundation

final class MusicViewModel {

    private var avPlayer: AVPlayer?
    private var avPlayerItem: AVPlayerItem?
    private var iTuneSongAPI: ITuneSongsAPI
    
    var iTuneMusic: ITuneMusic
    
    init(_ music: ITuneMusic, iTuneSongAPI: ITuneSongsAPI) {
        self.iTuneMusic = music
        self.iTuneSongAPI = iTuneSongAPI
    }
    
    func playSong() {
        if avPlayer != nil && avPlayer?.rate != 0 {
            avPlayer?.pause()
            return
        }
        guard let songURL = URL(string: iTuneMusic.previewUrl) else {
            fatalError("Invalid URL: \(iTuneMusic.previewUrl)")
        }
        avPlayerItem = AVPlayerItem(url: songURL)
        avPlayer = AVPlayer(playerItem: avPlayerItem)
        avPlayer?.play()
    }
}
