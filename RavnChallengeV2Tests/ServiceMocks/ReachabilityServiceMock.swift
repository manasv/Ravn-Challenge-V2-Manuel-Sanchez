//
//  ReachabilityServiceMock.swift
//  RavnChallengeV2Tests
//
//  Created by Manuel Sánchez on 11/11/20.
//

import Foundation
@testable import RavnChallengeV2

class ReachabilityServiceMock: ReachabilityServiceType {
    // MARK: Protocol Properties
    var networkIsReachable: Bool = false
    var serviceStarted: Bool = false
    
    // MARK: Mock Property
    var hasInternet: Bool
    var configureCount = 0
    
    init(hasInternet: Bool) {
        self.hasInternet = hasInternet
    }
    
    func configure() {
        if !serviceStarted {
            serviceStarted = true
            configureCount += 1
        }
        
        if !hasInternet {
            networkIsReachable = false
        } else {
            networkIsReachable = true
        }
    }
}
