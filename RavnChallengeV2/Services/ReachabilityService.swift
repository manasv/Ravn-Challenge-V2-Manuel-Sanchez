//
//  ReachabilityService.swift
//  RavnChallengeV2
//
//  Created by Manuel Sánchez on 11/11/20.
//

import Network
import Foundation

protocol ReachabilityServiceType {
    var networkIsReachable: Bool { get }
    var serviceStarted: Bool { get }
    func configure()
}

final class ReachabilityService: ReachabilityServiceType {
    private let monitor = NWPathMonitor()
    var networkIsReachable: Bool = true
    var serviceStarted = false
    
    func configure() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("We're connected!")
                self.networkIsReachable = true
            } else {
                print("No connection.")
                self.networkIsReachable = false
            }

            print(path.isExpensive)
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        
        serviceStarted = true
    }
}
