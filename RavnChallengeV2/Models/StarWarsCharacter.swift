//
//  StarWarsCharacter.swift
//  RavnChallengeV2
//
//  Created by Manuel Sánchez on 11/11/20.
//

import Foundation

struct StarWarsCharacter {
    let id: String
    let name: String
    let hairColor: String
    let eyeColor: String
    let skinColor: String
    let birthYear: String
    let species: String?
    let homeWorld: String
    let vehicles: [String]?
    
    var origin: String {
        if let species = species {
            return "\(species) from \(homeWorld)"
        } else {
            return "From \(homeWorld)"
        }
    }
}
