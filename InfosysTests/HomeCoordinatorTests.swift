//
//  HomeCoordinatorTests.swift
//  InfosysTests
//
//  Created by Saurav Mishra on 11/4/20.
//  Copyright © 2020 Saurav Mishra. All rights reserved.
//

import Foundation

import XCTest
@testable import Infosys

final class HomeCoordinatorTests: XCTestCase {

    func testStart() {
        let window = UIWindow()
        let navigationController = UINavigationController()
        let coordinator = HomeCoordinator(window: window, navigationController: navigationController)

        coordinator.start()

        XCTAssertTrue(window.isKeyWindow)
        XCTAssertEqual(window.rootViewController, coordinator.router.navigationController)
        XCTAssertEqual(coordinator.router.navigationController.viewControllers.count, 1)
        XCTAssertEqual(coordinator.router.navigationController.viewControllers[safe: 0], .homeViewController)
    }

}
