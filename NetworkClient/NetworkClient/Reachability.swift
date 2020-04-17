//
//  Reachability.swift
//  NetworkClient
//
//  Created by Saurav Mishra on 13/4/20.
//

import SystemConfiguration

/// Class to check if network is reachable or not.
final class Reachability: Reachable {

    static func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
         }
        }

       var flags = SCNetworkReachabilityFlags()

       if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
          return false
       }
       let isReachable = flags.contains(.reachable)
       let needsConnection = flags.contains(.connectionRequired)
       return (isReachable && !needsConnection)
    }

}

protocol Reachable: AnyObject {
    static func isInternetAvailable() -> Bool
}
