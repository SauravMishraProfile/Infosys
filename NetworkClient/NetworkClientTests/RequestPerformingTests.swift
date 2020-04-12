//
//  RequestPerformingTests.swift
//  NetworkClientTests
//
//  Created by Saurav Mishra on 12/4/20.
//
import XCTest
@testable import NetworkClient

final class RequestPerformingTests: XCTestCase {

    func testDefaultSession() {
        let requestPerforming = MockRequestPerforming()

        XCTAssertEqual(requestPerforming.session, .shared)
        XCTAssertEqual(requestPerforming.encodingStrategy, .utf8)
    }

    func testPerformRequestSuccess() {
        let requestPerforming = MockRequestPerforming()
        requestPerforming.response = Response.success(MockSuccessCodable(identifier: "12", name: "Name"))
        requestPerforming.performRequest { response in
            switch response {
            case .failure:
                XCTFail("Should not hit failure")
            case .success(let success):
                XCTAssertEqual(success.identifier, "12")
                XCTAssertEqual(success.name, "Name")
            }
        }
    }

    func testPerformRequestFailure() {
        let requestPerforming = MockRequestPerforming()
        requestPerforming.response = Response.failure(MockErrorCodable(code: "13"))
        requestPerforming.performRequest { response in
            switch response {
            case .failure(let error):
                let error = error as? MockErrorCodable
                XCTAssertEqual(error?.code, "13")
            case .success:
                XCTFail("Should not hit failure")
            }
        }
    }
}

private final class MockRequestPerforming: RequestPerforming {
    typealias ErrorModel = MockErrorCodable
    typealias SuccessModel = MockSuccessCodable

    var parameters: [String: Any] {
        return ["Parameter": "Value"]
    }

    var type: RequestType {
           return .get
    }

    var host: String {
        return "host.com.vic.gov.au"
    }

    var uri: String {
        return "/uri"
    }

    var response: Response<MockSuccessCodable>?
    func performRequest(completion: @escaping (Response<MockSuccessCodable>) -> Void) {
        completion(response!)
    }
}
