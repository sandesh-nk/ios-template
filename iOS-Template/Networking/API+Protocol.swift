//
//  API+Protocol.swift
//  iOS-Template
//
//  Created by Apple on 22/10/21.
//

import Foundation

protocol API {
    var networking: Networking { get }
    /// Set URL session as default in intializer implementation
    init(_ urlSessionConfiguration: URLSessionConfiguration)
}
