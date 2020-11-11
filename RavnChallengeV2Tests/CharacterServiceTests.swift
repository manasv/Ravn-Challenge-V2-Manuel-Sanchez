//
//  CharacterServiceTests.swift
//  RavnChallengeV2Tests
//
//  Created by Manuel Sánchez on 11/11/20.
//

import XCTest
import Foundation
import Combine

@testable import RavnChallengeV2

class CharacterServiceTests: XCTestCase {
    func testFetchCharacters() throws {
        // Given
        let characterService = CharacterServiceMock(serviceFail: false)
        var characterResponse: AllCharactersResponse?
        var subscriptions = Set<AnyCancellable>()
        
        // When
        characterService.allPeople(first: 1, after: nil)
            .sink { _ in }
                receiveValue: { response in
                characterResponse = response
                }.store(in: &subscriptions)

        _ = XCTWaiter.wait(for: [XCTestExpectation()], timeout: 0.1)
        
        // Then
        XCTAssertEqual(characterResponse?.characters.count, 1)
        let character = try XCTUnwrap(characterResponse?.characters.first)
        XCTAssertEqual(character.name, "MockName")
        XCTAssertEqual(character.eyeColor, "Green")
        XCTAssertEqual(character.id, "1")
    }
    
    func testFetchCharactersFail() throws {
        // Given
        let characterService = CharacterServiceMock(serviceFail: true)
        var receivedError: Error?
        var characterResponse: AllCharactersResponse?
        var subscriptions = Set<AnyCancellable>()
        
        // When
        characterService.allPeople(first: 1, after: nil)
            .sink { result in
                switch result {
                case .failure(let error):
                    receivedError = error
                case .finished:
                    break
                }
            } receiveValue: { response in
                characterResponse = response
            }
            .store(in: &subscriptions)

        _ = XCTWaiter.wait(for: [XCTestExpectation()], timeout: 0.1)
        
        // Then
        XCTAssertTrue(receivedError is MockError)
        XCTAssertNil(characterResponse)
    }
}
