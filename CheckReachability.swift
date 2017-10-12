//
//
//  CheckReachability.swift
//
//  Created by Nishanth P.
//  Copyright © 2017 Nishapp. All rights reserved.
//


import Foundation
import SystemConfiguration

open class CheckReachability {
    
    class func isDeviceConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var reachabilityFlags: SCNetworkReachabilityFlags = []
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &reachabilityFlags) == false {
            return false
        }
        
        let isReachable = reachabilityFlags.contains(.reachable)
        let needsConnection = reachabilityFlags.contains(.connectionRequired)
        
        return isReachable && !needsConnection
    }
    
}
