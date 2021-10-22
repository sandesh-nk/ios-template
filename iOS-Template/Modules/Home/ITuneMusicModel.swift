//
//  ITuneMusicModel.swift
//  iOS-Template
//
//  Created by Apple on 21/10/21.
//

import Foundation

struct ITuneMusicModel: Codable {
    let resultCount: Int
    let results: [ITuneMusic]
}

struct ITuneMusic: Codable {
    let trackName: String
    let collectionName: String?
    let artistName: String
    let previewUrl: String
}
