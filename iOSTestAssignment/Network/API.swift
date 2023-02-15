//
//  API.swift
//  iOSTestAssignment
//
//  Created by Naveed ur Rehman on 25/06/2022.
//

import Alamofire

struct API {
    static var baseURL: URL {
        guard let url = URL(string: "https://api.github.com/search/") else { fatalError() }
        return url
    }
    
    static var  path: String {
        return "users"
    }
}
