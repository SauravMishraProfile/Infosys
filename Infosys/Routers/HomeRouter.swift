//
//  HomeRouter.swift
//  Infosys
//
//  Created by Saurav Mishra on 11/4/20.
//  Copyright © 2020 Saurav Mishra. All rights reserved.
//

import UIKit

/// It encapsulates the navigation controller to carry out operations around navigation stack management - like push, pop, popToRoot and other more complex operations of stack manipulation originating out of the Home screen - the first screen.
final class HomeRouter: Router {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
