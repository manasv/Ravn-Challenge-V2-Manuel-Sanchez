//
//  CharacterServiceMock.swift
//  RavnChallengeV2Tests
//
//  Created by Manuel Sánchez on 11/11/20.
//

import Foundation
import Combine
@testable import RavnChallengeV2

struct CharacterServiceMock: CharacterServiceType {
    var serviceFail: Bool
    
    func allPeople(first: Int, after: String?) -> AnyPublisher<AllCharactersResponse, Error> {
        if !serviceFail {
            return Just(Mock.allCharactersResponse)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: MockError.genericError)
                .eraseToAnyPublisher()
        }
    }
}
