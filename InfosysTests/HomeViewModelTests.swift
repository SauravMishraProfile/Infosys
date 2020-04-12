//
//  HomeViewModelTests.swift
//  InfosysTests
//
//  Created by Saurav Mishra on 12/4/20.
//  Copyright © 2020 Saurav Mishra. All rights reserved.
//

import XCTest
@testable import Infosys
@testable import NetworkClient

final class HomeViewModelTests: XCTestCase {

    private var mockService: MockHomeServiceDelegate!

    override func setUp() {
        super.setUp()
        mockService = MockHomeServiceDelegate()
    }

    override func tearDown() {
        super.tearDown()
        mockService = nil
    }

    func testDataFeedFetchSuccess() {
        let mockHomeServiceProvider = MockHomeServiceProvider()

        let viewModel = HomeViewModel(service: mockHomeServiceProvider)
        viewModel.delegate = mockService

        let mockRow = DataFeed.Rows(title: "<Row Title>", description: "<Description>", imageHref: "<Image URL String>")
        let mockDataFeed = DataFeed(title: "<ScreenTitle>", rows: [mockRow])
        mockHomeServiceProvider.mockCompletion = Response.success(mockDataFeed)

        viewModel.fetchData()

        XCTAssertEqual(viewModel.state, .success)
        XCTAssertEqual(viewModel.screenTitle, "<ScreenTitle>")
        XCTAssertEqual(viewModel.cellViewModels.count, 1)
        XCTAssertEqual(viewModel.cellViewModels[safe: 0]?.title, "<Row Title>")
        XCTAssertEqual(viewModel.cellViewModels[safe: 0]?.description, "<Description>")
        XCTAssertEqual(viewModel.cellViewModels[safe: 0]?.imageURLString, "<Image URL String>")
        XCTAssertTrue(mockService.didSucceedCalled)
    }

    func testDataFeedFetchFailure() {
        let mockHomeServiceProvider = MockHomeServiceProvider()

        let viewModel = HomeViewModel(service: mockHomeServiceProvider)
        viewModel.delegate = mockService

        let errorModel = DefaultErrorModel(errorCode: 0, description: "<Error Model>")
        mockHomeServiceProvider.mockCompletion = Response.failure(errorModel)

        viewModel.fetchData()

        XCTAssertEqual(viewModel.state, .failure)
        XCTAssertNil(viewModel.screenTitle)
        XCTAssertEqual(viewModel.cellViewModels.count, 0)
        XCTAssertTrue(mockService.didFailCalled)
        XCTAssertEqual(viewModel.errorModel?.errorCode, 0)
        XCTAssertEqual(viewModel.errorModel?.description, "<Error Model>")
    }

    func testErrorMessages() {
        XCTAssertEqual(HomeViewModel.ErrorState.message, "Something went wrong!")
        XCTAssertEqual(HomeViewModel.ErrorState.title, "Error")
        XCTAssertEqual(HomeViewModel.ErrorState.done, "OK")
    }

}

private final class MockHomeServiceProvider: HomeServiceProvider {

    var mockCompletion: Response<DataFeed>?
    func fetchHomeData(completion: @escaping (Response<DataFeed>) -> Void) {
        completion(mockCompletion!)
    }

}

private final class MockHomeServiceDelegate: HomeServiceDelegate {

    var didSucceedCalled: Bool = false
    func didSucceed(_ viewModel: HomeViewModel) {
        didSucceedCalled = true
    }

    var didFailCalled: Bool = false
    func didFail(_ viewModel: HomeViewModel) {
        didFailCalled = true
    }
}
