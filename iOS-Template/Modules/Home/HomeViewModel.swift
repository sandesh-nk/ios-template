//
//  HomeViewModel.swift
//  iOS-Template
//
//  Created by Viranchee on 30/03/21.
//

import Foundation

final class HomeViewModel {
    /// The network call that is happening in async currently
    private (set) var model: [String] = []
    private var searchString: String = ""
    private var nextPage = 1
    
    init() { }
    
    func searchStringChanged(newString: String, callback: @escaping Callback<Result<String, NetworkingError>>) {
    }
    
    private func searchUsers(callback: @escaping Callback<Result<String, NetworkingError>>) {
    }
}
