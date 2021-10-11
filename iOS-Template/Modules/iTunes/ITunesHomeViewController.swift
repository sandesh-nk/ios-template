//
//  ITunesHomeViewController.swift
//  iOS-Template
//
//  Created by Apple on 10/10/21.
//

import UIKit

protocol ITunesHomeViewControllerDelegate: class {
    func iTunesHomeViewControllerDidSelect(_ item: ITuneResult)
}

class ITunesHomeViewController: UIViewController {
    
    weak var delegate: ITunesHomeViewControllerDelegate!
    var viewModel: ITunesHomeViewModel
    
    lazy var searchBar = UISearchBar()
    lazy var tableView = UITableView()
    
    init(viewModel: ITunesHomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "iTunes Movie Search"
        
        searchBar.placeholder = "Movie Name"
        searchBar.delegate = self
        searchBar.accessibilityIdentifier = "movieSearchBar"
        searchBar.accessibilityLabel = "Enter movie name to Search"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(UITableViewCell.self)
        tableView.accessibilityLabel = "List of Movies"
        
        layoutViews()
    }
    
    func layoutViews() {
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

extension ITunesHomeViewController: UISearchBarDelegate {
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

extension ITunesHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let userName = viewModel.model[indexPath.row].trackName
        cell.textLabel?.text = userName
        cell.accessibilityLabel = userName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        let item = viewModel.model[indexPath.row]
        delegate.iTunesHomeViewControllerDidSelect(item)
    }
}
