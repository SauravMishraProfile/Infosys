//
//  RequestBuilder.swift
//  VicTrams
//
//  Created by Saurav Mishra on 11/4/20.
//

import Foundation

protocol RequestBuilder: URLEncoder & JSONEncoder { }

protocol URLEncoder {
    static func makeURL(for configuration: RequestConfiguring) -> URL
}

extension URLEncoder {
    static func makeURL(for configuration: RequestConfiguring) -> URL {
        switch configuration.type {
        case .get:
            var urlComponents = URLComponents()
            urlComponents.path = configuration.uri

            if !configuration.parameters.isEmpty {
                urlComponents.queryItems = [URLQueryItem]()

                for (key, value) in configuration.parameters {
                    let queryItem = URLQueryItem(name: key,
                                                 value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                    urlComponents.queryItems?.append(queryItem)
                }
            }

            urlComponents.scheme = configuration.scheme
            urlComponents.host = configuration.host
            return urlComponents.url ?? configuration.endPoint
        default:
            var urlComponents = URLComponents()
            urlComponents.path = configuration.uri
            urlComponents.scheme = configuration.scheme
            urlComponents.host = configuration.host
            return urlComponents.url ?? configuration.endPoint
        }
    }
}

protocol JSONEncoder {
    static func make(for configuration: RequestConfiguring) -> Data?
}

extension JSONEncoder {
    static func make(for configuration: RequestConfiguring) -> Data? {
        switch configuration.type {
        case .post:
            do {
                return try JSONSerialization.data(withJSONObject: configuration.parameters, options: .prettyPrinted)
            } catch {
                return nil
            }
        default:
            return nil
        }
    }
}

struct DefaultRequestBuilder: RequestBuilder { }
