//
//  Networking.swift
//  ios-template
//
//  Created by Viranchee on 15/03/21.
//

import UIKit

struct Networking {
    
    let configuration: URLSessionConfiguration
    
    init(configuration: URLSessionConfiguration = .default) {
        self.configuration = configuration
    }
    
    func request<A: Codable>(endpoint: Endpoint, completion: @escaping (Result<A, NetworkingError>) -> Void) {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.params
        guard let url = components.url else {
            completion(.failure(.urlcomponentError))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        let session = URLSession(configuration: configuration)
        
        print(url.absoluteString)
        
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
           if let error = error {
                if let urlError = error as? URLError {
                    completion(.failure(.urlError(urlError)))
                } else {
                    completion(.failure(.apiError(error)))
                    print(error.localizedDescription)
                }
                return
            }
            guard response != nil, let data = data else { return }
            DispatchQueue.main.async {
                
                if let responseObject = try? JSONDecoder().decode(A.self, from: data) {
                    completion(.success(responseObject))
                } else {
                    completion(.failure(.jsonDecodingError))
                }
            }
        }
        dataTask.resume()
    }
}
