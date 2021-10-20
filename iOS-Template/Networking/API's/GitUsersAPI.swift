//
//  GitUsers+API.swift
//  iOS-Template
//
//  Created by Apple on 07/10/21.
//

import Foundation

struct GitUsersAPI {
    let networking: Networking
    
    init(_ urlSessionConfiguration: URLSessionConfiguration = .default) {
        self.networking = Networking(configuration: urlSessionConfiguration)
    }

    func searchUsers(query: String, page: Int, completion: @escaping (Result<GithubModel, NetworkingError>) -> Void) {
        let endpoint = GithubEndpoint.user(searchText: query, page: page)
        networking.request(endpoint: endpoint) { result in
            completion(result)
        }
    }
}
