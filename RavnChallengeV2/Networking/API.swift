//
//  API.swift
//  RavnChallengeV2
//
//  Created by Manuel Sánchez on 10/11/20.
//

import Foundation
import Apollo

enum API {
    static let baseURL: URL = URL(string: "https://swapi-graphql.netlify.app/.netlify/functions/index")!
}

struct ApiError: Error {
    let errors: [GraphQLError]
    
    var message: String {
        errors.map(\.localizedDescription).joined(separator: "\n")
    }
}
