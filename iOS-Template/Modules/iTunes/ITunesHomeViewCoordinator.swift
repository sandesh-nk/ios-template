//
//  ITunesHomeViewCoordinator.swift
//  iOS-Template
//
//  Created by Apple on 10/10/21.
//

import UIKit

final class ITunesHomeViewCoordinator: Coordinator {
  private weak var presenter: UINavigationController?
    private var iTunesHomeViewController: ITunesHomeViewController?
    private var iTunesItemDetailViewController: ITunesItemDetailViewController?
    private let environment: Environment
    
    init(presenter: UINavigationController?, environment: Environment) {
    self.presenter = presenter
    self.environment = environment
  }
    
    func start() {
        let iTunesHomeViewModel = ITunesHomeViewModel()
        let iTunesHomeViewController = ITunesHomeViewController(viewModel: iTunesHomeViewModel)
        iTunesHomeViewController.delegate = self
        presenter?.pushViewController(iTunesHomeViewController, animated: true)
        self.iTunesHomeViewController = iTunesHomeViewController
    }
    
}

extension ITunesHomeViewCoordinator: ITunesHomeViewControllerDelegate {
    func iTunesHomeViewControllerDidSelect(_ item: ITuneResult) {
        let iTuneDetailViewModel = ItunesItemDetailViewModel(item)
        iTunesItemDetailViewController = ITunesItemDetailViewController(iTuneDetailViewModel)
        presenter?.pushViewController(iTunesItemDetailViewController!, animated: true)
    }
    
}
