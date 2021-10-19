//
//  GitUsers+API.swift
//  iOS-Template
//
//  Created by Apple on 07/10/21.
//

import Foundation

protocol GitUserAPIProtocol {
    mutating func searchUsers(query: String, page: Int, completion: @escaping (Result<GithubModel, NetworkingError>) -> Void)
}

struct GitUsersAPI: GitUserAPIProtocol {
    var networking = Networking()
    
    func generateURL(for user: String, page: Int) -> URL? {
        guard var urlComp = URLComponents(url: Environment.baseURL, resolvingAgainstBaseURL: false) else {
            fatalError("Unable to generate base URL")
        }
        urlComp.path = "/search/users"
        let query = "q=\"\(user)\"&page=\(String(page))"
        urlComp.query = query
        print(urlComp.url?.absoluteString)
        return urlComp.url
    }
    
    mutating func searchUsers(query: String, page: Int, completion: @escaping (Result<GithubModel, NetworkingError>) -> Void) {
        let searchURL = generateURL(for: query, page: page)
        networking.genericURLSession(url: searchURL, completion: completion)
    }
}
