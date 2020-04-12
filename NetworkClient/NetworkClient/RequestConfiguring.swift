//
//  RequestConfiguring.swift
//  VicTrams
//
//  Created by Saurav Mishra on 11/4/20.
//

import Foundation

public protocol RequestConfiguring: EndPoint {
     var type: RequestType { get }
     var parameters: [String: Any] { get }
}

extension RequestConfiguring {
    var parameters: [String: Any] {
        return [:]
    }
}

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