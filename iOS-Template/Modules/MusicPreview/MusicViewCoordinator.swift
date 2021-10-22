//
//  MusicViewCoordinator.swift
//  iOS-Template
//
//  Created by Apple on 22/10/21.
//

import UIKit

class MusicViewCoordinator: Coordinator {
    private var presenter: UINavigationController
    private var musicViewController: MusicViewController
    private let iTuneMusic: ITuneMusic
    
    init(presenter: UINavigationController, iTuneMusic: ITuneMusic) {
        self.presenter = presenter
        self.iTuneMusic = iTuneMusic
        let musicViewModel = MusicViewModel(iTuneMusic, iTuneSongAPI: ITuneSongsAPI())
        musicViewController = MusicViewController(musicViewModel)
    }
    
    func start() {
        presenter.pushViewController(musicViewController, animated: true)
    }
}
