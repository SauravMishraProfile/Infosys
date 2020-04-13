//
//  RequestConfiguring.swift
//  VicTrams
//
//  Created by Saurav Mishra on 11/4/20.
//

import Foundation

/// Configure the request with type and parameters.
public protocol RequestConfiguring: EndPoint {
     var type: RequestType { get }
     var parameters: [String: Any] { get }
}

/// Protocol to generate the endpoint
public protocol EndPoint {
    var scheme: String { get }
    var host: String { get }
    var uri: String { get }
    var endPoint: URL { get }
}

public extension EndPoint {

    var scheme: String {
        return "https"
    }

    var endPoint: URL {
        return URL(string: self.scheme + "://" + self.host + self.uri)!
    }

}
