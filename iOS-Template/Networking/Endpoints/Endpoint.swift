//
//  Endpoint.swift
//  iOS-Template
//
//  Created by Viranchee on 02/04/21.
//

import UIKit

protocol Endpoint {
    // HTTP or HTTPS
    var scheme: String { get }
    
    // Example itunes.apple.com
    var baseURL: String { get }
    
    // /search/
    var path: String { get }
    
    // search?term=taylor+swift
    var params: [URLQueryItem] { get }
    
    var method: String { get }
}
