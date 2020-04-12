//
//  HomeCoordinator.swift
//  Infosys
//
//  Created by Saurav Mishra on 11/4/20.
//  Copyright © 2020 Saurav Mishra. All rights reserved.
//

import UIKit

final class HomeCoordinator: Coordinator {

    private lazy var homeViewController: HomeViewController = {
        let homeViewModel = HomeViewModel()
        let homeViewController: HomeViewController = .homeViewController
        homeViewController.viewModel = homeViewModel
        homeViewController.coordinator = self
        return homeViewController
    }()

    private let window: UIWindow

    var router: Router

    init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.router = HomeRouter(navigationController: navigationController)
    }

    func start() {
        router.navigationController.viewControllers = [homeViewController]
        window.rootViewController = router.navigationController
        window.makeKeyAndVisible()
    }
}
