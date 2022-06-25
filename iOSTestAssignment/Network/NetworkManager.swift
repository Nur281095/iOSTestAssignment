//
//  NetworkManager.swift
//  iOSTestAssignment
//
//  Created by Naveed ur Rehman on 25/06/2022.
//

import Moya

protocol Networkable {
    var provider: MoyaProvider<API> { get }
    func fetchSearchResult(query: String, page: Int, per_page: Int, completion: @escaping (Result<SearchResponse, Error>) -> ())
}

class NetworkManager: Networkable {
    var provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin()])
    func fetchSearchResult(query: String, page: Int, per_page: Int, completion: @escaping (Result<SearchResponse, Error>) -> ()) {
        request(target: .users(searchQ: query, page: page, per_page: per_page), completion: completion)
    }
}

private extension NetworkManager {
    private func request<T: Decodable>(target: API, completion: @escaping (Result<T, Error>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    print(response)
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}


