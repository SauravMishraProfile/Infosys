//
//  Coordinator.swift
//  Infosys
//
//  Created by Saurav Mishra on 11/4/20.
//  Copyright © 2020 Saurav Mishra. All rights reserved.
//

import Foundation

protocol Coordinator: AnyObject {

    func start()
    var router: Router { get }
}
