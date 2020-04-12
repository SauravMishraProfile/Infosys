//
//  AppCoordinatorTests.swift
//  InfosysTests
//
//  Created by Saurav Mishra on 11/4/20.
//  Copyright © 2020 Saurav Mishra. All rights reserved.
//

import XCTest
@testable import Infosys

final class AppCoordinatorTests: XCTestCase {

    func testStart() {
        let window = UIWindow()
        let appCoordinator = AppCoordinator(window: window)

        appCoordinator.start()

        XCTAssertEqual(appCoordinator.childCoordinators.count, 1)
        XCTAssertEqual(appCoordinator.router.navigationController.viewControllers.count, 1)

        guard let homeCoordinator = appCoordinator.childCoordinators[safe: 0] as? HomeCoordinator else {
            XCTFail("Child Coordinator is not HomeCoordinator")
            return
        }
        XCTAssertNotNil(homeCoordinator)
    }

}

final class MockCoordinator: Coordinator {

    var startCalled: Int = 0
    func start() {
        startCalled += 1
    }

    let router: Router = MockRouter()

}

final class MockRouter: Router {
    let navigationController = UINavigationController()
}

extension Array {
    subscript(safe index: Int) -> Element? {
        guard indices.contains(index) != false else {
            XCTFail("Index out of range")
            return nil
        }

        return self[index]
    }
}
