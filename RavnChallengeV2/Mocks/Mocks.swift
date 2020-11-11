//
//  Mocks.swift
//  RavnChallengeV2
//
//  Created by Manuel Sánchez on 11/11/20.
//

import Foundation

enum Mock {
    static let starWarsCharacters = [
        StarWarsCharacter(id: "1",
                          name: "Character 1",
                          hairColor: "Brown",
                          eyeColor: "Blue",
                          skinColor: "Fair",
                          birthYear: "10AC",
                          species: "Human",
                          homeWorld: "Tatooine",
                          vehicles: ["Vehicle 1", "Vehicle 2"]),
        StarWarsCharacter(id: "2",
                          name: "Character 2",
                          hairColor: "Brown",
                          eyeColor: "Blue",
                          skinColor: "Fair",
                          birthYear: "10AC",
                          species: "Human",
                          homeWorld: "Tatooine",
                          vehicles: ["Vehicle 1"]),
        StarWarsCharacter(id: "3",
                          name: "Character 3",
                          hairColor: "Brown",
                          eyeColor: "Blue",
                          skinColor: "Fair",
                          birthYear: "10AC",
                          species: nil,
                          homeWorld: "Tatooine",
                          vehicles: nil)
    ]
    
    static let singleCharacter = StarWarsCharacter(id: "1",
                                                   name: "Lonely Man",
                                                   hairColor: "Brown",
                                                   eyeColor: "Blue",
                                                   skinColor: "Fair",
                                                   birthYear: "10AC",
                                                   species: "Human",
                                                   homeWorld: "Tatooine",
                                                   vehicles: ["Vehicle 1", "Vehicle 2"])
}
