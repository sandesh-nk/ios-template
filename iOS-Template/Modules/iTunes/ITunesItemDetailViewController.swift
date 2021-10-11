//
//  ITunesItemDetailViewController.swift
//  iOS-Template
//
//  Created by Apple on 10/10/21.
//

import UIKit
import SnapKit
class ITunesItemDetailViewController: UIViewController {

    private var viewModal: ItunesItemDetailViewModel
    private var detailLabel = UILabel()
    
    init(_ viewModel: ItunesItemDetailViewModel) {
        self.viewModal = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModal.iTuneItem.trackName
        detailLabel.numberOfLines = 0
        detailLabel.text = viewModal.iTuneItem.longDescription
        layoutView()
    }
    
    private func layoutView() {
        view.backgroundColor = .white
        view.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { make in
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(16)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(16)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-16)
            make.bottom.lessThanOrEqualTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
