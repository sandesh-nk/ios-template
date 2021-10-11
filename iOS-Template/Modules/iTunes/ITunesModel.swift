//
//  iTunesModel.swift
//  iOS-Template
//
//  Created by Apple on 10/10/21.
//

import Foundation

struct ITunesModel: Codable {
    let resultCount: Int
    let results: [ITuneResult]
}

// MARK: - Result
struct ITuneResult: Codable {
    let trackName: String
    let longDescription: String
}
