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
    var listeners = [NetworkStatusListener]()
    
    func startMonitoring() {
        NotificationCenter.default.addObserver(self, selector: #selector(ReachabilityManager.reachabilityChanged(_:)), name: .reachabilityChanged, object: reachability)
        
        do {
            try reachability.startNotifier()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func stopMonitoring() {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
    
    func hasConnection() -> Bool {
        switch reachability.connection {
            case .wifi, .cellular: return true
            case .none:            return false
        }
    }
    
    func addListener(_ listener: NetworkStatusListener) {
        listeners.append(listener)
    }
    
    func removeListener(_ listener: NetworkStatusListener) {
        listeners = listeners.filter{ $0 !== listener}
    }
    
    @objc func reachabilityChanged(_ notification: Notification) {
        let reachability = notification.object as! Reachability
        
        for listener in listeners {
            listener.networkStatusDidChange(status: reachability.connection)
        }
    }
    
}

public protocol NetworkStatusListener: class {

    func networkStatusDidChange(status: Reachability.Connection)

}
