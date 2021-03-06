//
//  ResponseGeneratingTests.swift
//  NetworkClientTests
//
//  Created by Saurav Mishra on 12/4/20.
//
import XCTest
@testable import NetworkClient

final class ResponseGeneratingTests: XCTestCase {

    func testResponseGeneratingSuccess() {

        let responseJSON = """
                            { "identifier":"13", "name":"Jack & Jill" }
                            """.utf8

        let httpResponse = HTTPURLResponse(url: URL(string: "http://mock.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let responseGenerator = ResponseGenerator()
        let response = responseGenerator.decode(successDecodingType: MockSuccessCodable.self, errorDecodingType: MockErrorCodable.self, data: Data(responseJSON), response: httpResponse, error: nil)

        switch response {
        case .failure:
            XCTFail("Not Supposed to hit Failure")
        case .success(let success):
            XCTAssertEqual(success.name, "Jack & Jill")
            XCTAssertEqual(success.identifier, "13")
        }

    }

    func testResponseGeneratingFailureInvalidResposne() {

        let responseJSON = """
                            { "age":"13", "name":"Jack & Jill" }
                            """.utf8

        let httpResponse = HTTPURLResponse(url: URL(string: "http://mock.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let responseGenerator = ResponseGenerator()
        let response = responseGenerator.decode(successDecodingType: MockSuccessCodable.self, errorDecodingType: MockErrorCodable.self, data: Data(responseJSON), response: httpResponse, error: nil)

        switch response {
        case .failure(let error):
            let generatedError = error as? DefaultErrorModel
            XCTAssertNotNil(generatedError)
            XCTAssertEqual(generatedError?.errorCode, 0)
            XCTAssertEqual(generatedError?.description, "The data couldn’t be read because it is missing.")
        case .success:
            XCTFail("Not Supposed to hit Success")
        }

    }

    func testResponseGeneratingFailureErrorResponseFromServer() {

        let responseJSON = """
                            { "code":"13" }
                            """.utf8

        let httpResponse = HTTPURLResponse(url: URL(string: "http://mock.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let responseGenerator = ResponseGenerator()
        let response = responseGenerator.decode(successDecodingType: MockSuccessCodable.self, errorDecodingType: MockErrorCodable.self, data: Data(responseJSON), response: httpResponse, error: nil)

        switch response {
        case .failure(let error):
            let generatedError = error as? MockErrorCodable
            XCTAssertNotNil(generatedError)
            XCTAssertEqual(generatedError?.code, "13")
        case .success:
            XCTFail("Not Supposed to hit Success")
        }

    }

    func testResponseGeneratingFailureErrorReceievedInServiceCall() {

        let responseJSON = """
                            { "code":"13" }
                            """.utf8

        let httpResponse = HTTPURLResponse(url: URL(string: "http://mock.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let responseGenerator = ResponseGenerator()
        let response = responseGenerator.decode(successDecodingType: MockSuccessCodable.self, errorDecodingType: MockErrorCodable.self, data: Data(responseJSON), response: httpResponse, error: DefaultError())

        switch response {
        case .failure(let error):
            let generatedError = error as? DefaultErrorModel
            XCTAssertNotNil(generatedError)
            XCTAssertEqual(generatedError?.errorCode, 0)
            XCTAssertEqual(generatedError?.description, "Error Returned")
        case .success:
            XCTFail("Not Supposed to hit Success")
        }

    }

    func testResponseGeneratingInvalidHTTPCodeReceived() {

        let responseJSON = """
                            { "code":"13" }
                            """.utf8

        let httpResponse = HTTPURLResponse(url: URL(string: "http://mock.com")!, statusCode: 404, httpVersion: nil, headerFields: nil)
        let responseGenerator = ResponseGenerator()
        let response = responseGenerator.decode(successDecodingType: MockSuccessCodable.self, errorDecodingType: MockErrorCodable.self, data: Data(responseJSON), response: httpResponse, error: nil)

        switch response {
        case .failure(let error):
            let generatedError = error as? MockErrorCodable
            XCTAssertNotNil(generatedError)
            XCTAssertEqual(generatedError?.code, "13")
        case .success:
            XCTFail("Not Supposed to hit Success")
        }

    }

    func testResponseGeneratingNonHTTPURLResponseReceived() {

        let responseJSON = """
                               { "code":"13" }
                               """.utf8

        let httpResponse = URLResponse()
        let responseGenerator = ResponseGenerator()
        let response = responseGenerator.decode(successDecodingType: MockSuccessCodable.self, errorDecodingType: MockErrorCodable.self, data: Data(responseJSON), response: httpResponse, error: DefaultError())

        switch response {
        case .failure(let error):
            let generatedError = error as? DefaultErrorModel
            XCTAssertNotNil(generatedError)
            XCTAssertEqual(generatedError?.errorCode, 0)
            XCTAssertEqual(generatedError?.description, "Error Returned")
        case .success:
            XCTFail("Not Supposed to hit Success")
        }
    }

    func testResponseGeneratingWronglyEncodedResponseRecieved() {

        let mockSuccessCodable = MockResponseObject()
        mockSuccessCodable.name = "Name"
        let data = NSKeyedArchiver.archivedData(withRootObject: mockSuccessCodable)
         let httpResponse = HTTPURLResponse(url: URL(string: "http://mock.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let responseGenerator = ResponseGenerator()
        let response = responseGenerator.decode(successDecodingType: MockSuccessCodable.self, errorDecodingType: MockErrorCodable.self, data: data, response: httpResponse, error: nil)

        switch response {
        case .failure(let error):
            let generatedError = error as? DefaultErrorModel
            XCTAssertNotNil(generatedError)
            XCTAssertEqual(generatedError?.errorCode, 0)
            XCTAssertEqual(generatedError?.type, .invalidData)
            XCTAssertEqual(generatedError?.description, "could not convert data to UTF-8 format")
        case .success:
            XCTFail("Not Supposed to hit Success")
        }
    }

    func testResponseGeneratingInternetReachableFalse() {

        let responseJSON = """
                            { "identifier":"13", "name":"Jack & Jill" }
                            """.utf8

        let httpResponse = HTTPURLResponse(url: URL(string: "http://mock.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let responseGenerator = ResponseGenerator(isInternetReachable: false)
        let response = responseGenerator.decode(successDecodingType: MockSuccessCodable.self, errorDecodingType: MockErrorCodable.self, data: Data(responseJSON), response: httpResponse, error: nil)

        switch response {
        case .failure(let error):
            let generatedError = error as? DefaultErrorModel
            XCTAssertNotNil(generatedError)
            XCTAssertEqual(generatedError?.errorCode, 0)
            XCTAssertEqual(generatedError?.type, .noInternet)
            XCTAssertEqual(generatedError?.description, "Error Returned")
        case .success:
            XCTFail("Not Supposed to hit Success")
        }
    }

}

struct MockSuccessCodable: Codable {
    let identifier: String
    let name: String
}

struct MockErrorCodable: Codable {
    let code: String
}

struct DefaultError: Error { }

@objc(MockResponseObject)
private class MockResponseObject: NSObject, NSCoding {

   var name: String?
   override init() { }

   func encode(with aCoder: NSCoder) {
       aCoder.encode(self.name, forKey: "name")
   }

   required init(coder decoder: NSCoder) {
       if let name = decoder.decodeObject(forKey: "name") as? String {
            self.name = name
       }
   }
}
