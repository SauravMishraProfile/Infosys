//
//  Router.swift
//  Infosys
//
//  Created by Saurav Mishra on 11/4/20.
//  Copyright © 2020 Saurav Mishra. All rights reserved.
//

import UIKit

/// It encapsulates the navigation controller to carry out operations around navigation stack management - like push, pop, popToRoot and other more complex operations of stack manipulation. The Router is owned by Coordinator.
protocol Router: AnyObject {
    var navigationController: UINavigationController { get }
}
