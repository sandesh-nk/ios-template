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
        searchBar.delegate = self
        searchBar.accessibilityIdentifier = "search bar"
        searchBar.accessibilityLabel = "Search song"
        
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
        searchBar.accessibilityIdentifier = "music list tabel"
        tableView.accessibilityLabel = "List of songs"
        
        layoutViews()
        bindTableView()
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
    
    private func bindTableView() {
        viewModel.model
            .subscribe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: UITableViewCell.description())) { (_, repository: ITuneMusic, cell) in
                    cell.textLabel?.text = repository.trackName
                    cell.accessibilityLabel = repository.trackName
            }.disposed(by: self.disposeBag)
        
        //TODO:- Add binding of row selection
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, searchText != "" else { return }
        viewModel.searchStringChanged(newString: searchText) { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchStringChanged(newString: searchText) { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        // let item = viewModel.model.value[indexPath.row]
        // delegate.homeViewControllerDidSelect(item)
    }
}
