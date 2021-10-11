//
//  ITunesMovieAPI.swift
//  iOS-Template
//
//  Created by Apple on 10/10/21.
//

import Foundation

protocol ITunesMovieAPIProtocol {
    mutating func searchMovie(query name: String, completion: @escaping (Result<ITunesModel, NetworkingError>) -> Void)
}

struct ITunesMovieAPI {
    var networking = Networking()
    
    func generateURL(for movie: String) -> URL? {
        var urlComp = URLComponents(string: Constants.iTunesURL)!
        let searchString = movie.replacingOccurrences(of: " ", with: "+")
        let query = "term=\(searchString)&media=movie"
        urlComp.query = query
        return urlComp.url
    }
    
    mutating func searchMovie(query name: String, completion: @escaping (Result<ITunesModel, NetworkingError>) -> Void) {
        let searchURL = generateURL(for: name)
        networking.genericURLSession(url: searchURL, completion: completion)
    }
}
