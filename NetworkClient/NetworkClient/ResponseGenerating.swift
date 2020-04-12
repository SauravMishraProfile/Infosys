//
//  ResponseGenerating.swift
//  VicTrams
//
//  Created by Saurav Mishra on 11/4/20.
//

import Foundation

protocol ResponseGenerating {
    var decoder: JSONDecoder { get }
    var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy { get }
    var encodingStrategy: String.Encoding { get }
    func decode<T: Codable, U: Codable>(successDecodingType: T.Type, errorDecodingType: U.Type, data: Data?, response: URLResponse?, error: Error?) -> Response<T>
}

enum DateError: String, Error {
    case invalidDate
}

extension ResponseGenerating {
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = self.dateDecodingStrategy
        return decoder
    }

    var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy {
        return .iso8601
    }

    func decode<T: Codable, U: Codable>(successDecodingType: T.Type, errorDecodingType: U.Type, data: Data?, response: URLResponse?, error: Error?) -> Response<T> {
        guard let responseData = data,
            error == nil else {
                let errorModel = DefaultErrorModel(type: .general, errorCode: 0, description: "Error Returned")
                return .failure(errorModel)
        }

        guard Reachability.isInternetAvailable() else {
            let errorModel = DefaultErrorModel(type: .noInternet, errorCode: 0, description: "Error Returned")
            return .failure(errorModel)
        }

        guard let response = response as? HTTPURLResponse,
            (200...299).contains(response.statusCode) else {
                return self.makeFailureResponse(responseData: responseData, errorDecodingType: errorDecodingType)
        }

        do {
            let responseString = String(data: responseData, encoding: self.encodingStrategy)
            guard let modifiedDataInUTF8Format = responseString?.data(using: .utf8) else {
                let errorModel = DefaultErrorModel(type: .invalidData, errorCode: 0, description: "could not convert data to UTF-8 format")
                  return .failure(errorModel)
             }
            let response = try self.decoder.decode(successDecodingType, from: modifiedDataInUTF8Format)
            return .success(response)
        } catch let error {
            print(error)
            return self.makeFailureResponse(responseData: responseData, errorDecodingType: errorDecodingType)
        }
    }

    private func makeFailureResponse<T: Codable, U: Codable>(responseData: Data, errorDecodingType: U.Type) -> Response<T> {
        do {
            let response = try self.decoder.decode(errorDecodingType, from: responseData)
            return .failure(response)
        } catch let error {
            let errorModel = DefaultErrorModel(type: .invalidData, errorCode: 0, description: error.localizedDescription)
            return .failure(errorModel)
        }
    }
}

struct ResponseGenerator: ResponseGenerating {
    let encodingStrategy: String.Encoding
    init(encodingStrategy: String.Encoding = .utf8) {
        self.encodingStrategy = encodingStrategy
    }
}
