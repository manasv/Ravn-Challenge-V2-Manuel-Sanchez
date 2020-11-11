//
//  CharacterDetailViewModel.swift
//  RavnChallengeV2
//
//  Created by Manuel Sánchez on 11/11/20.
//

import Foundation

final class CharacterDetailViewModel: ObservableObject {
    let character: StarWarsCharacter

    init(character: StarWarsCharacter) {
        self.character = character
    }
}
