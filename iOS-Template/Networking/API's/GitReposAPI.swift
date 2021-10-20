//
//  GitReposAPI.swift
//  iOS-Template
//
//  Created by Apple on 07/10/21.
//

import Foundation



struct GitReposAPI {
    var networking = Networking()
    
    init(_ urlSessionConfiguration: URLSessionConfiguration = .default) {
        self.networking = Networking(configuration: urlSessionConfiguration)
    }
    
    func getRepos(of user: String, completion: @escaping (Result<[Repository], NetworkingError>) -> Void) {
        let endpoint = GithubEndpoint.repos(username: user)
        networking.request(endpoint: endpoint) { result in
            completion(result)
        }
    }
}
