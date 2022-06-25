//
//  LoginVM.swift
//  iOSTestAssignment
//
//  Created by Naveed ur Rehman on 25/06/2022.
//

import UIKit

protocol ViewModelProtocol: AnyObject {
    func didUpdateSearchResult()
}

class LoginVM {
    
    weak var delegate: ViewModelProtocol?
    
    fileprivate(set) var searchResponse: SearchResponse?
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func search(with query: String, page_no page: Int, per_page_limit limit: Int) {
        networkManager.fetchSearchResult(query: query, page: page, per_page: limit) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let searchResponse):
                strongSelf.searchResponse = searchResponse
                strongSelf.delegate?.didUpdateSearchResult()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

