//
//  ITuneMusicModel.swift
//  iOS-Template
//
//  Created by Apple on 21/10/21.
//

import Foundation

struct ITuneMusicModel: Codable {
    let resultCount: Int
    let items: [ITuneMusic]
}

struct ITuneMusic: Codable {
    let trakName: String
    let longDescription: String
}
