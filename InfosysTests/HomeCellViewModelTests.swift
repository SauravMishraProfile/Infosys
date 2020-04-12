//
//  HomeCellViewModel.swift
//  InfosysTests
//
//  Created by Saurav Mishra on 12/4/20.
//  Copyright © 2020 Saurav Mishra. All rights reserved.
//

import XCTest
@testable import Infosys
@testable import NetworkClient

final class HomeCellViewModelTests: XCTestCase {

    func testHomeCellViewModelNil() {
        let viewModel = HomeCellViewModel(imageURLString: nil, title: nil, description: nil)

        XCTAssertNil(viewModel)
    }

    func testShouldDownloadImageTrue() {
         let viewModel = HomeCellViewModel(imageURLString: "http://mock", title: nil, description: nil)
        XCTAssertTrue(viewModel!.shouldDownloadImage)
    }

    func testShouldDownloadImageFalse() {
         let viewModel = HomeCellViewModel(imageURLString: nil, title: "<Title>", description: nil)
        XCTAssertFalse(viewModel!.shouldDownloadImage)
    }

    func testShouldHideTitleLabelFalse() {
         let viewModel = HomeCellViewModel(imageURLString: nil, title: "<Title>", description: nil)
        XCTAssertFalse(viewModel!.shouldHideTitleLabel)
    }

    func testShouldHideTitleLabelTrue() {
         let viewModel = HomeCellViewModel(imageURLString: nil, title: nil, description: "<Description>")
        XCTAssertTrue(viewModel!.shouldHideTitleLabel)
    }

    func testShouldHideDescriptionLabelFalse() {
        let viewModel = HomeCellViewModel(imageURLString: nil, title: nil, description: "<Description>")
        XCTAssertFalse(viewModel!.shouldHideDescriptionLabel)
    }

    func testShouldHideDescriptionLabelTrue() {
        let viewModel = HomeCellViewModel(imageURLString: nil, title: "<Title>", description: nil)
        XCTAssertTrue(viewModel!.shouldHideDescriptionLabel)
    }
}
