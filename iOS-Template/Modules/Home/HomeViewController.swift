//
//  HomeViewController.swift
//  ios-template
//
//  Created by Viranchee on 15/03/21.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

protocol HomeViewControllerDelegate: AnyObject {
    func homeViewControllerDidSelect(_ track: ITuneMusic)
}

final class HomeViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    weak var delegate: HomeViewControllerDelegate!
    var viewModel: HomeViewModel
    lazy var searchBar = UISearchBar()
    lazy var tableView = UITableView()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.iTuneMusicSearch
        
        searchBar.placeholder = L10n.searchTrack
        searchBar.accessibilityIdentifier = "search bar"
        searchBar.accessibilityLabel = "Search song"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
        searchBar.accessibilityIdentifier = "music list tabel"
        tableView.accessibilityLabel = "List of songs"
        
        layoutViews()
        bindViews()
    }
    
    private func layoutViews() {
        view.backgroundColor = .white
        view.addSubview(searchBar)
        // Search Bar Layout
        searchBar.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
        }
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func bindViews() {
        searchBar.rx.text.orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
            .subscribe(onNext: { str in
                self.viewModel.searchStringChanged(newString: str) { _ in }
            })
            .disposed(by: disposeBag)
                            
        viewModel.model
            .subscribe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: UITableViewCell.description())) { (_, repository: ITuneMusic, cell) in
                cell.textLabel?.text = repository.trackName
                cell.accessibilityLabel = repository.trackName
            }.disposed(by: self.disposeBag)
        
        tableView.rx.modelSelected(ITuneMusic.self)
            .subscribe { iTuneMusic in
                self.delegate?.homeViewControllerDidSelect(iTuneMusic)
            }.disposed(by: disposeBag)
    }
}
