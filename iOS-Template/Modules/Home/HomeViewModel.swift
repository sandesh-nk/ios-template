//
//  HomeViewModel.swift
//  iOS-Template
//
//  Created by Viranchee on 30/03/21.
//

import Foundation
import RxSwift
import RxRelay

final class HomeViewModel {
    /// The network call that is happening in async currently
    private (set) var model: PublishSubject<[ITuneMusic]> = PublishSubject<[ITuneMusic]>()
    private var searchString: String = ""
    private var iTuneSongAPI: ITuneSongsAPIProtcol
    
    init(iTuneSongAPI: ITuneSongsAPIProtcol) {
        self.iTuneSongAPI = iTuneSongAPI
    }
    
    func searchStringChanged(newString: String, callback: @escaping Callback<Result<ITuneMusicModel, NetworkingError>>) {
        self.searchString = newString
        iTuneSongAPI.searchSong(newString) { [weak self] resultModel in
            guard let self = self else { return }
            switch resultModel {
            case .success(let iTuneModel):
                self.model.on(.next(iTuneModel.results))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
