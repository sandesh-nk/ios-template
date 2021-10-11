//
//  ITunesHomeViewModel.swift
//  iOS-Template
//
//  Created by Apple on 10/10/21.
//

import Foundation

final class ITunesHomeViewModel {
    /// The network call that is happening in async currently
    private (set) var model: [ITuneResult] = []
    private var searchString: String = ""
    private var nextPage = 1
    var iTunesMovieAPI: ITunesMovieAPI
    
    init() {
        self.iTunesMovieAPI = ITunesMovieAPI()
    }
    
    func searchStringChanged(newString: String, callback: @escaping Callback<Result<ITunesModel, NetworkingError>>) {
        self.searchString = newString
        self.nextPage = 1
        model = []
        print(searchString)
        searchMovie { (result) in
            callback(result)
        }
    }
    
    private func searchMovie(callback: @escaping Callback<Result<ITunesModel, NetworkingError>>) {
        iTunesMovieAPI.searchMovie(query: searchString) { [weak self] resultModel in
            guard let self = self else { return }
            switch resultModel {
            case .success(let model):
                self.model += model.results
                self.nextPage += 1
            case .failure(let error):
                // FIXME: Handle Error
                dump(error)
            }
            callback(resultModel)
        }
    }
    
}
