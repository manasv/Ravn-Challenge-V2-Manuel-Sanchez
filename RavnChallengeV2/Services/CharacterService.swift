//
//  CharacterService.swift
//  RavnChallengeV2
//
//  Created by Manuel Sánchez on 10/11/20.
//

import Foundation
import Combine

typealias AllPerson = AllPeopleQuery.Data.AllPerson
typealias Person = AllPerson.Person
typealias PageInfo = AllPerson.PageInfo

struct AllCharactersResponse {
    var characters: [Person]
    var pageInfo: PageInfo
    
    static var initial: AllCharactersResponse {
        let pageInfo = PageInfo(hasNextPage: false, endCursor: nil)
        
        return AllCharactersResponse(characters: [], pageInfo: pageInfo)
    }
}

protocol CharacterServiceType {
    func allPeople(first: Int, after: String?) -> AnyPublisher<AllCharactersResponse, Error>
}

struct CharacterService: CharacterServiceType {
    var client = NetworkClient.shared
    
    func allPeople(first: Int, after: String?) -> AnyPublisher<AllCharactersResponse, Error> {
        client
            .execute(query: AllPeopleQuery(first: first, after: after))
            .map { data -> AllCharactersResponse in
                let characters = data.allPeople?.people?.compactMap { $0 } ?? []
                let pageInfo = data.allPeople?.pageInfo ?? PageInfo(hasNextPage: false, endCursor: nil)
                
                return AllCharactersResponse(characters: characters, pageInfo: pageInfo)
            }.eraseToAnyPublisher()
    }
    
    static func make() -> CharacterService {
        .init()
    }
}
