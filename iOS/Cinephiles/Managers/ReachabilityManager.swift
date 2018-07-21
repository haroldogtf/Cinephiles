//
//  ReachabilityManager.swift
//  Cinephiles
//
//  Created by Haroldo Gondim on 21/07/18.
//

import Reachability

class ReachabilityManager: NSObject {

    static let shared = ReachabilityManager()
    
    let reachability = Reachability()!
    
    func startMonitoring() {
        do {
            try reachability.startNotifier()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func stopMonitoring() {
        reachability.stopNotifier()
    }
    
    func hasInternetConnection() -> Bool{
        switch reachability.connection {
        case .wifi, .cellular: return true
        case .none:            return false
        }
        
    }

}
