//
//  SongsTestData.swift
//  iOS-TemplateTests
//
//  Created by Apple on 22/10/21.
//

import Foundation
 //FIXME: Move sample data to .txt files

struct SongsTestData {
    static let songsSmapleData = Data(sampleData.utf8)
    
    static let sampleData = """
    {
    "resultCount":1,
    "results":[
       {
          "wrapperType":"track",
          "kind":"song",
          "artistId":1750802,
          "collectionId":668424099,
          "trackId":668424101,
          "artistName":"Skillet",
          "collectionName":"Awake (Deluxe Edition)",
          "trackName":"Monster",
          "collectionCensoredName":"Awake (Deluxe Edition)",
          "trackCensoredName":"Monster",
          "artistViewUrl":"https://music.apple.com/us/artist/skillet/1750802?uo=4",
          "collectionViewUrl":"https://music.apple.com/us/album/monster/668424099?i=668424101&uo=4",
          "trackViewUrl":"https://music.apple.com/us/album/monster/668424099?i=668424101&uo=4",
          "previewUrl":"https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/49/e0/66/49e06626-47db-411a-ed6e-7ced44e79cde/mzaf_15983204636766187579.plus.aac.p.m4a",
          "artworkUrl30":"https://is5-ssl.mzstatic.com/image/thumb/Music4/v4/7e/0d/de/7e0dde7d-cd3d-d844-36b0-4d1963687eba/source/30x30bb.jpg",
          "artworkUrl60":"https://is5-ssl.mzstatic.com/image/thumb/Music4/v4/7e/0d/de/7e0dde7d-cd3d-d844-36b0-4d1963687eba/source/60x60bb.jpg",
          "artworkUrl100":"https://is5-ssl.mzstatic.com/image/thumb/Music4/v4/7e/0d/de/7e0dde7d-cd3d-d844-36b0-4d1963687eba/source/100x100bb.jpg",
          "collectionPrice":11.99,
          "trackPrice":1.29,
          "releaseDate":"2009-07-14T07:00:00Z",
          "collectionExplicitness":"notExplicit",
          "trackExplicitness":"notExplicit",
          "discCount":1,
          "discNumber":1,
          "trackCount":15,
          "trackNumber":2,
          "trackTimeMillis":178013,
          "country":"USA",
          "currency":"USD",
          "primaryGenreName":"Hard Rock",
          "isStreamable":true
       }
    ]
    }
"""
}


