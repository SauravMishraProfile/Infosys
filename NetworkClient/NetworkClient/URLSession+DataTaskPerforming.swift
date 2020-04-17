//
//  URLSession+DataTaskManaging.swift
//  NetworkClient
//
//  Created by Saurav Mishra on 17/4/20.
//

extension URLSession: URLSessionProtocol {
    public func makeDataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTaskProtocol
    }
}

public protocol URLSessionProtocol {
    func makeDataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

public protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
