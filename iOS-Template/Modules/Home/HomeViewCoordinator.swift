//
//  HomeViewCoordinator.swift
//  iOS-Template
//
//  Created by Viranchee on 30/03/21.
//

import UIKit

final class HomeViewCoordinator: Coordinator {
    
    private var presenter: UINavigationController
    private var homeViewController: HomeViewController
    private var musicViewCoordinator: MusicViewCoordinator?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        let homeViewModel = HomeViewModel(iTuneSongAPI: ITuneSongsAPI())
        homeViewController = HomeViewController(viewModel: homeViewModel)
    }
    
    func start() {
        homeViewController.delegate = self
        presenter.pushViewController(homeViewController, animated: true)
    }
}

extension HomeViewCoordinator: HomeViewControllerDelegate {
    func homeViewControllerDidSelect(_ track: ITuneMusic) {
        let musicViewCoordinator = MusicViewCoordinator(presenter: presenter, iTuneMusic: track)
        musicViewCoordinator.start()
        self.musicViewCoordinator = musicViewCoordinator
    }
}
