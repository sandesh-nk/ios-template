//
//  ITunesSongAPIMockConfigs.swift
//  iOS-Template
//
//  Created by Sandesh on 26/10/21.
//

import Foundation

struct ITunesSongAPIMockConfigs {
    static var basicConfig: URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        URLProtocolMock.requestHandler = { request in
            return (HTTPURLResponse(), SongsTestData.songsSmapleData)
        }
        configuration.protocolClasses = [URLProtocolMock.self]
        return configuration
    }
}
