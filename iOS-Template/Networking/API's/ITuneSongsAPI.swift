//
//  ITuneSongsAPI.swift
//  iOS-Template
//
//  Created by Apple on 20/10/21.
//

import Foundation

protocol ITuneSongsAPIProtcol: API {
    func searchSong(_ seachText: String, completion: @escaping (Result<ITuneMusicModel, NetworkingError>) -> Void)
}

struct ITuneSongsAPI {
    let networking: Networking
    
    init(_ urlSessionConfiguration: URLSessionConfiguration = .default) {
        self.networking = Networking(configuration: urlSessionConfiguration)
    }
    
    func searchSong(_ seachText: String, completion: @escaping (Result<ITuneMusicModel, NetworkingError>) -> Void) {
        let endpoint = ITunesEndpoint.getSong(searchText: seachText)
        networking.request(endpoint: endpoint, completion: completion)
    }
}
