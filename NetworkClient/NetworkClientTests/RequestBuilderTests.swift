//
//  RequestBuilderTests.swift
//  NetworkClientTests
//
//  Created by Saurav Mishra on 11/4/20.
//

import XCTest
@testable import NetworkClient

final class RequestBuilderTests: XCTestCase {

    func testURLEncoderMockParametersGET() {
        let mockRequestConfiguration = MockRequestConfiguration()
        let url = DefaultRequestBuilder.makeURL(for: mockRequestConfiguration)

        XCTAssertEqual(url.absoluteString, "https://host.com.vic.gov.au/uri?Parameter=Value")
        XCTAssertEqual(mockRequestConfiguration.endPoint, URL(string: "https://host.com.vic.gov.au/uri"))
    }

    func testURLEncoderEmptyParametersGET() {
        let mockRequestConfiguration = MockRequestConfiguration()
        mockRequestConfiguration.mockParameters = [:]
        let url = DefaultRequestBuilder.makeURL(for: mockRequestConfiguration)

        XCTAssertEqual(url.absoluteString, "https://host.com.vic.gov.au/uri")
    }

    func testURLEncoderPOST() {
        let mockRequestConfiguration = MockRequestConfiguration()
        mockRequestConfiguration.mockType = .post
        let url = DefaultRequestBuilder.makeURL(for: mockRequestConfiguration)

        XCTAssertEqual(url.absoluteString, "https://host.com.vic.gov.au/uri")
    }

    func testJSONEncodingPOST() {
        let mockRequestConfiguration = MockRequestConfiguration()
        mockRequestConfiguration.mockType = .post
        let parameters: [String: Any] = [
            "id": 13,
            "name": "Jack & Jill"
        ]
        mockRequestConfiguration.mockParameters = parameters

        let data = DefaultRequestBuilder.make(for: mockRequestConfiguration)

        XCTAssertNotNil(data)
    }

    func testJSONEncodingGET() {
        let mockRequestConfiguration = MockRequestConfiguration()
        let data = DefaultRequestBuilder.make(for: mockRequestConfiguration)

        XCTAssertNil(data)
    }

}

private final class MockRequestConfiguration: RequestConfiguring {

    var host: String {
        return "host.com.vic.gov.au"
    }

    var uri: String {
        return "/uri"
    }

    var mockType: RequestType? = .get
    var type: RequestType {
        return mockType!
    }

    var mockParameters: [String: Any]? = ["Parameter": "Value"]
    var parameters: [String: Any] {
        return mockParameters!
    }
}
