//
//  GithubEndpoints.swift
//  iOS-Template
//
//  Created by Viranchee on 02/04/21.
//

import Foundation

enum GithubEndpoint: Endpoint {
    case user(searchText: String, page: Int)
    case repos(username: String)
    
    var scheme: String {
        switch self {
        default: return "https"
        }
    }
    
    var baseURL: String {
        return Environment.baseURL.absoluteString
    }
    
    var path: String {
        switch self {
        case .user:
            return "/search/users"
        case .repos(let user):
            return "/users/\(user)/repos"
        }
    }
    
    var params: [URLQueryItem] {
        switch self {
        case .user(let searchText, let page):
            return [URLQueryItem(name: "q", value: searchText),
                    URLQueryItem(name: "page", value: "\(page)")]
        case .repos :
           return []
        }
    }
    
    var method: String {
        switch self {
        default: return "get"
        }
    }
}
