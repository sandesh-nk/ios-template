//
//  URLProtocolMock.swift
//  iOS-Template
//
//  Created by Apple on 20/10/21.
//

import Foundation

class URLProtocolMock: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?

    // say we want to handle all types of request
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    // ignore this method; just send back what we were given
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
            guard let handler = URLProtocolMock.requestHandler else {
                fatalError("No request handler found")
            }
            do {
                let (response, data) = try handler(request)
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                client?.urlProtocol(self, didLoad: data)
                client?.urlProtocolDidFinishLoading(self)
            } catch {
                client?.urlProtocol(self, didFailWithError: error)
            }
        }
    
    // this method is required but doesn't need to do anything
    override func stopLoading() { }
    
    override var cachedResponse: CachedURLResponse? {
        CachedURLResponse(response: URLResponse(), data: Data())
    }
}
