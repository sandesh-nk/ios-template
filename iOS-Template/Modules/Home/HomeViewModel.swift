//
//  HomeViewModel.swift
//  iOS-Template
//
//  Created by Viranchee on 30/03/21.
//

import Foundation

final class HomeViewModel {
    /// The network call that is happening in async currently
    private (set) var model: [ITuneMusic] = []
    private var searchString: String = ""
    private var iTuneMusicAPI: ITuneSongsAPI
    
    init() {
        iTuneMusicAPI = ITuneSongsAPI()
    }
    
    func searchStringChanged(newString: String, callback: @escaping Callback<Result<ITuneMusicModel, NetworkingError>>) {
        self.searchString = newString
        self.model = []
        
        iTuneMusicAPI.searchMusic(newString) { [weak self] resultModel in
            guard let self = self else { return }
            
            switch resultModel {
            case .success(let iTuneModel):
                self.model += iTuneModel.items
            case .failure(let error):
                print(error.localizedDescription)
            }
            callback(resultModel)
        }
    }
}
