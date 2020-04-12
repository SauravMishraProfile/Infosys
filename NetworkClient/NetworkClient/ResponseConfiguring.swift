//
//  ResponseConfiguring.swift
//  VicTrams
//
//  Created by Saurav Mishra on 11/4/20.
//

import Foundation

public protocol ResponseConfiguring {
    associatedtype ErrorModel: Codable
    associatedtype SuccessModel: Codable
    var encodingStrategy: String.Encoding { get }
}

public extension ResponseConfiguring {
    var encodingStrategy: String.Encoding {
        return .utf8
    }
}

public struct DefaultErrorModel: Codable {
    let errorCode: Int
    let description: String
}

public enum Response<SuccessValue> {
    case success(SuccessValue)
    case failure(Codable)
}
