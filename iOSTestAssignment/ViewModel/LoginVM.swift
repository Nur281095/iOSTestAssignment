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
    
    func search(with query: String, page_no page: Int, per_page_limit limit: Int) {
        var params = [String: AnyObject]()
        params["page"] = page as AnyObject
        params["per_page"] = limit as AnyObject
        params["q"] = query as AnyObject
        
        SRWebClient.GET("\(API.baseURL)\(API.path)")
            .data(params)
            .send({ response, status in
                if let searchs = self.convertStringToDictionary(text: response as? String ?? "") {
                    self.searchResponse = SearchResponse(fromDictionary: searchs)
                    self.delegate?.didUpdateSearchResult()
                }
            }, failure: { error in
                print(error?.localizedDescription as Any)
                
            })
    }
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
}

