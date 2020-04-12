//
//  AppCoordinator.swift
//  Infosys
//
//  Created by Saurav Mishra on 11/4/20.
//  Copyright © 2020 Saurav Mishra. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {

    let router: Router
    let childCoordinators: [Coordinator]
    private let window: UIWindow

    init(navigationController: UINavigationController =  UINavigationController(), window: UIWindow) {
        self.router = AppRouter(navigationController: navigationController)
        self.window = window
        self.childCoordinators = [HomeCoordinator(window: window, navigationController: navigationController)]
    }

    func start() {
        guard let childCoordinator = childCoordinators.first else { return }
        router.navigationController.viewControllers = childCoordinator.router.navigationController.viewControllers
        childCoordinator.start()
    }
}
