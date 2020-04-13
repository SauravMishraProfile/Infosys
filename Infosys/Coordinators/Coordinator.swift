//
//  Coordinator.swift
//  Infosys
//
//  Created by Saurav Mishra on 11/4/20.
//  Copyright © 2020 Saurav Mishra. All rights reserved.
//

import Foundation

/// A coordinator which controls the flows in the app. It has a start() method to initate the flow and can have other methods like next() or stop() to carry further operations adn supply dependencies. It has a`router` object which can helps in managing the navigation stack.
protocol Coordinator: AnyObject {

    func start()
    var router: Router { get }
}
