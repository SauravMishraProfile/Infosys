//
//  AppCoordinator.swift
//  Infosys
//
//  Created by Saurav Mishra on 11/4/20.
//  Copyright © 2020 Saurav Mishra. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {

    // MARK: - Properties

    // MARK: Private

    private let childCoordinators: [Coordinator]
    private let window: UIWindow

    // MARK: Internal

    let router: Router

    // MARK: - Initialiser

    init(navigationController: UINavigationController =  UINavigationController(), window: UIWindow) {
        self.router = AppRouter(navigationController: navigationController)
        self.window = window
        self.childCoordinators = [HomeCoordinator(window: window, navigationController: navigationController)]
    }

    // MARK: - Methods

    // MARK: Internal

    func start() {
        guard let childCoordinator = childCoordinators.first else { return }
        router.navigationController.viewControllers = childCoordinator.router.navigationController.viewControllers
        childCoordinator.start()
    }
}
