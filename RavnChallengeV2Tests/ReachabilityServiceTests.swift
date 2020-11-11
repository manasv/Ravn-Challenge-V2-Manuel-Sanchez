//
//  ReachabilityServiceTests.swift
//  RavnChallengeV2Tests
//
//  Created by Manuel Sánchez on 10/11/20.
//

import XCTest
@testable import RavnChallengeV2

class ReachabilityServiceTests: XCTestCase {
    func testConfigureReachability() {
        // Given
        let reachability = ReachabilityServiceMock(hasInternet: true)
        
        // When
        reachability.configure()
        
        // Then
        XCTAssertTrue(reachability.serviceStarted)
        XCTAssertTrue(reachability.networkIsReachable)
    }
    
    func testFailConfigureReachability() {
        // Given
        let reachability = ReachabilityServiceMock(hasInternet: false)
        
        // When
        reachability.configure()
        
        // Then
        XCTAssertTrue(reachability.serviceStarted)
        XCTAssertFalse(reachability.networkIsReachable)
    }
    
    func testReachabilityServiceOnlyIsConfiguredOnce() {
        // Given
        let reachability = ReachabilityServiceMock(hasInternet: true)
        
        // When
        reachability.configure()
        reachability.configure()
        
        // Then
        XCTAssertTrue(reachability.serviceStarted)
        XCTAssertTrue(reachability.networkIsReachable)
        XCTAssertEqual(reachability.configureCount, 1)
    }
}
