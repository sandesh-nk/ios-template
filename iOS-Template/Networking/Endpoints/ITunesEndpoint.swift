//
//  ITunesEndpoint.swift
//  iOS-Template
//
//  Created by Apple on 20/10/21.
//

import Foundation

enum ITunesEndpoint: Endpoint {
    case getSong(searchText: String)
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return "itunes.apple.com"
        }
    }
    
    var path: String {
        switch self {
        case .getSong:
            return "/search"
        }
    }
    
    var params: [URLQueryItem] {
        switch self {
        case .getSong(var searchTerm):
            searchTerm = searchTerm.replacingOccurrences(of: " ", with: "+")
            return [URLQueryItem(name: "term", value: searchTerm),
                    URLQueryItem(name: "media", value: "music")
            ]
        }
    }
    
    var method: String {
        switch self {
        case .getSong:
            return "get"
        }
    }
}
