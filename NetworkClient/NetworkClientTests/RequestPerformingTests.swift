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
        guard let session = requestPerforming.session as? MockURLSession else {
            XCTFail("Mock session is not used")
            return
        }
        let responseJSON = """
        { "identifier":"13", "name":"Jack & Jill" }
        """.utf8
        session.data = Data(responseJSON)
        session.response = HTTPURLResponse(url: URL(string: "http://mock.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        requestPerforming.performRequest { response in
            switch response {
            case .failure:
                XCTFail("Should not hit failure")
            case .success(let success):
                XCTAssertEqual(success.identifier, "13")
                XCTAssertEqual(success.name, "Jack & Jill")
            }
        }
    }

    func testPerformRequestFailure() {
        let requestPerforming = MockRequestPerforming()
        guard let session = requestPerforming.session as? MockURLSession else {
            XCTFail("Mock session is not used")
            return
        }
        session.error = DefaultError()
        requestPerforming.performRequest { response in
            switch response {
            case .failure(let error):
                let error = error as? DefaultErrorModel
                XCTAssertEqual(error?.description, "Error Returned")
                XCTAssertEqual(error?.errorCode, 0)
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

    let session: URLSessionProtocol
    init(session: URLSessionProtocol = MockURLSession()) {
        self.session = session
    }

}

private final class MockURLSession: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    private(set) var dataTask = MockDataTask()

    func makeDataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        completionHandler(data, response, error)
        return dataTask
    }
}

private final class MockDataTask: URLSessionDataTaskProtocol {

    private(set) var resumeCalledCount: Int = 0
    func resume() {
        resumeCalledCount += 1
    }
}
