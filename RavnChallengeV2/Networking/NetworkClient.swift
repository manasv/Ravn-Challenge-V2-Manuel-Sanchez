//
//  NetworkClient.swift
//  RavnChallengeV2
//
//  Created by Manuel Sánchez on 10/11/20.
//

import Foundation
import Combine
import Apollo

final class NetworkClient {
    static let shared = NetworkClient()
    private lazy var apolloClient = ApolloClient(url: API.baseURL)
    
    func execute<T: GraphQLQuery>(query: T) -> AnyPublisher<T.Data, Error> {
        Future { [weak self] promise in
            self?.apolloClient.fetch(query: query) { result in
                switch result {
                case .success(let response):
                    if let responseData = response.data {
                        return promise(.success(responseData))
                    } else if let errors = response.errors {
                        let apiError = ApiError(errors: errors)
                        
                        return promise(.failure(apiError))
                    }
                case .failure(let error):
                    return promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
