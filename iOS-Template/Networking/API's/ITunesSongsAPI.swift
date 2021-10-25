//
//  ITunesSongsAPI.swift
//  iOS-Template
//
//  Created by Apple on 20/10/21.
//

import Foundation

struct ITunesSongsAPI {
    let networking: Networking
    
    init(_ urlSessionConfiguration: URLSessionConfiguration = .default) {
        self.networking = Networking(configuration: urlSessionConfiguration)
    }
    
}
