//
//  NetworkReachability.swift
//  NewsApp
//
//  Created by Chetan N on 23/07/24.
//

import Foundation
import Network

//Class is used for network checking
class NetworkReachability {
    static let shared = NetworkReachability()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    private init() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("Network is reachable")
            } else {
                print("Network is not reachable")
            }
        }
        
    }
    
    func isReachable() -> Bool {
        return monitor.currentPath.status == .satisfied
    }
}
