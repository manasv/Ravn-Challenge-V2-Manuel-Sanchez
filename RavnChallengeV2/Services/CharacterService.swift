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
}

struct CharacterService {
    let client = NetworkClient.shared
    
    func allPeople() -> AnyPublisher<AllCharactersResponse, Error> {
        client
            .execute(query: AllPeopleQuery(first: 5, after: ""))
            .map { data -> AllCharactersResponse in
                let characters = data.allPeople?.people?.compactMap { $0 } ?? []
                let pageInfo = data.allPeople?.pageInfo ?? PageInfo(hasNextPage: false, hasPreviousPage: false,
                                                                    startCursor: nil, endCursor: nil)
                
                return AllCharactersResponse(characters: characters, pageInfo: pageInfo)
            }.eraseToAnyPublisher()
    }
}
