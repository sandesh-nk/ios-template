//
//  HomeViewController.swift
//  ios-template
//
//  Created by Viranchee on 15/03/21.
//

import UIKit
import SnapKit

protocol HomeViewControllerDelegate: AnyObject {
    func homeViewControllerDidSelect(_ track: ITuneMusic)
}

final class HomeViewController: UIViewController {
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
        searchBar.accessibilityIdentifier = "githubSearchBar"
        searchBar.accessibilityLabel = "Enter Github Username to Search"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(UITableViewCell.self)
        tableView.accessibilityLabel = "List of Users"
        
        layoutViews()
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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let iTuneMusic = viewModel.model[indexPath.row]
        cell.textLabel?.text = iTuneMusic.trackName
        cell.accessibilityLabel = iTuneMusic.trackName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        let item = viewModel.model[indexPath.row]
        delegate.homeViewControllerDidSelect(item)
    }
}
