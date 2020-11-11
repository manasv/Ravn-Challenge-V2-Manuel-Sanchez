//
//  CharacterListViewModelTests.swift
//  RavnChallengeV2Tests
//
//  Created by Manuel Sánchez on 11/11/20.
//

import Foundation
import XCTest

@testable import RavnChallengeV2

class CharacterListViewModelTests: XCTestCase {
    func testFetchCharacters() throws {
        // Given
        let viewModel = CharacterListViewModel(service: CharacterServiceMock(serviceFail: false),
                                               reachability: ReachabilityServiceMock(hasInternet: true),
                                               characters: [])
        
        // When
        viewModel.fetchCharacters()
        
        // Then
        XCTAssertEqual(viewModel.state.characters.count, 1)
        let character = try XCTUnwrap(viewModel.state.characters.first)
        XCTAssertEqual(character.name, "MockName")
        XCTAssertFalse(viewModel.state.isLoading)
        XCTAssertFalse(viewModel.state.loadingFailed)
    }
    
    func testFetchCharactersFailed() throws {
        // Given
        let viewModel = CharacterListViewModel(service: CharacterServiceMock(serviceFail: true),
                                               reachability: ReachabilityServiceMock(hasInternet: true),
                                               characters: [])
        
        // When
        viewModel.fetchCharacters()
        
        // Then
        XCTAssertTrue(viewModel.state.characters.isEmpty)
        XCTAssertNil(viewModel.state.characters.first)
        XCTAssertFalse(viewModel.state.isLoading)
        XCTAssertTrue(viewModel.state.loadingFailed)
    }
    
    func testTryToFetchWithoutInternet() throws {
        // Given
        let reachability = ReachabilityServiceMock(hasInternet: false)
        
        let viewModel = CharacterListViewModel(service: CharacterServiceMock(
                                                serviceFail: !reachability.networkIsReachable),
                                               reachability: reachability,
                                               characters: [])
        
        // When
        viewModel.fetchCharacters()
        
        // Then
        XCTAssertTrue(viewModel.state.characters.isEmpty)
        XCTAssertNil(viewModel.state.characters.first)
        XCTAssertFalse(viewModel.state.isLoading)
        XCTAssertTrue(viewModel.state.loadingFailed)
    }

}
