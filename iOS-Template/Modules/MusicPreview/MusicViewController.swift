//
//  MusicViewController.swift
//  iOS-Template
//
//  Created by Apple on 22/10/21.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol MusicViewControllerDelegate: AnyObject {
    func musicViewController(playSong url: String)
}

class MusicViewController: UIViewController {

    private var viewModel: MusicViewModel
    private lazy var musicDetailstackViewContainer: UIView = UIView()
    private lazy var musicDetailStackView: UIStackView = UIStackView()
    private lazy var trackNameLabel: UILabel = UILabel()
    private lazy var artistLabel: UILabel = UILabel()
    private lazy var collectionNameLabel: UILabel = UILabel()
    private lazy var previewButton: UIButton = UIButton()
    
    private let disposeBag = DisposeBag()
    
    weak var delegate: MusicViewControllerDelegate?
    
    init(_ viewModel: MusicViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        layoutViews()
        bindViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
    }
    
    private func layoutViews() {
        view.backgroundColor = .white
        
        // music detail stack view container
        view.addSubview(musicDetailstackViewContainer)
        musicDetailstackViewContainer.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.height.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.7)
        }
        
        // music detail stack view
        musicDetailstackViewContainer.addSubview(musicDetailStackView)
        musicDetailStackView.snp.makeConstraints { make in
            make.left.equalTo(musicDetailstackViewContainer.snp.left).offset(16)
            make.right.equalTo(musicDetailstackViewContainer.snp.right).offset(-16)
            make.centerX.centerY.equalToSuperview()
        }
        
        // track name label
        musicDetailStackView.addArrangedSubview(trackNameLabel)
        musicDetailStackView.addArrangedSubview(artistLabel)
        musicDetailStackView.addArrangedSubview(collectionNameLabel)
        
        // preview button
        
        view.addSubview(previewButton)
        previewButton.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(16)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.height.equalTo(44)
        }
    }
    
    private func setupViews() {
        
        musicDetailStackView.axis = .vertical
        musicDetailStackView.distribution = .fillEqually
        
        trackNameLabel.numberOfLines = 0
        trackNameLabel.textAlignment = .center
        artistLabel.numberOfLines = 0
        artistLabel.textAlignment = .center
        collectionNameLabel.numberOfLines = 0
        collectionNameLabel.textAlignment = .center
        
        trackNameLabel.text = viewModel.iTuneMusic.trackName
        artistLabel.text = viewModel.iTuneMusic.artistName
        artistLabel.text = viewModel.iTuneMusic.collectionName ?? ""
        
        previewButton.backgroundColor = .red
        previewButton.titleLabel?.textColor = .white
        previewButton.layer.cornerRadius = 8
        previewButton.clipsToBounds = true
        previewButton.isUserInteractionEnabled = true
        previewButton.setTitle(L10n.previewSong, for: .normal)
    }
    
    private func bindViews() {
        previewButton.rx.tap.asObservable()
            .subscribe { _ in
                self.viewModel.playSong() }
            .disposed(by: disposeBag)
    }
}
