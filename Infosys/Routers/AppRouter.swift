//
//  AppRouter.swift
//  Infosys
//
//  Created by Saurav Mishra on 11/4/20.
//  Copyright © 2020 Saurav Mishra. All rights reserved.
//

import UIKit

/// The App Router takes care of managing the all other viewControllers that can be launched from the app screen. For example in an app, login can take the user to Dashboard or Settings tab in a tab bar controlled application.
final class AppRouter: Router {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
