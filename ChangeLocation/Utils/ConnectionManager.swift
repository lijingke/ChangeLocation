//
//  ConnectionManager.swift
//  CustomizationGlass
//
//  Created by 李京珂 on 2021/8/21.
//

import Foundation
import Reachability

class ConnectionManager {
    static let sharedInstance = ConnectionManager()
    private var reachability: Reachability!

    func observeReachability() {
        reachability = try! Reachability()
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged), name: NSNotification.Name.reachabilityChanged, object: nil)
        do {
            try reachability.startNotifier()
        } catch {
            LogUtil.log("Error occured while starting reachability notifications : \(error.localizedDescription)")
        }
    }

    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        switch reachability.connection {
        case .cellular:
            LogUtil.log("Network available via Cellular Data.")
        case .wifi:
            LogUtil.log("Network available via WiFi.")
        case .none:
            LogUtil.log("Network is not available.")
        case .unavailable:
            LogUtil.log("Network is unavailable.")
        }
    }
}
