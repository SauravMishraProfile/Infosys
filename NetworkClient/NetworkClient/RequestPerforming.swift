//
//  RequestPerforming.swift
//  VicTrams
//
//  Created by Saurav Mishra on 11/4/20.
//  Copyright © 2019 Mohapatra, Garima. All rights reserved.
//

import Foundation

public enum RequestType: String {
    case get = "GET"
    case post = "POST"
}

/// Protocol to perform the request.
public protocol RequestPerforming: ResponseConfiguring & RequestConfiguring {
    func performRequest (completion: @escaping (Response<SuccessModel>) -> Void)
    var session: URLSession { get }
}

extension RequestPerforming {

    public var session: URLSession {
        return .shared
    }

    public func performRequest (completion: @escaping (Response<SuccessModel>) -> Void) {
        let url = DefaultRequestBuilder.makeURL(for: self)
        var networkRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        networkRequest.httpMethod = self.type.rawValue
        networkRequest.httpBody = DefaultRequestBuilder.make(for: self)

        let task = session.dataTask(with: networkRequest, completionHandler: { (data, response, error) in
            let responseGenerator = ResponseGenerator(encodingStrategy: self.encodingStrategy)
            let response = responseGenerator.decode(successDecodingType: SuccessModel.self, errorDecodingType: ErrorModel.self, data: data, response: response, error: error)
            completion(response)
        })
        task.resume()
    }
}
