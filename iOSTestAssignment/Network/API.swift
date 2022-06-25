//
//  API.swift
//  iOSTestAssignment
//
//  Created by Naveed ur Rehman on 25/06/2022.
//

import Moya

enum API {
    case users(searchQ: String, page: Int, per_page: Int)
}

extension API: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.github.com/search/") else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .users:
            return "users"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .users(let query, let page, let per_page):
            return .requestParameters(parameters: ["q" : query, "page" : page, "per_page" : per_page], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

