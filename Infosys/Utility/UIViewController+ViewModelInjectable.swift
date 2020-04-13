//
//  UIViewController+ViewModelInjectable.swift
//  Infosys
//
//  Created by Saurav Mishra on 11/4/20.
//  Copyright © 2020 Saurav Mishra. All rights reserved.
//

import UIKit

/// A protocol to be implemented by UIVIewControllers which mandates that they should have a viewModel and a coordinator attached to them.
protocol ViewModelInjectable where Self: UIViewController {

    associatedtype DependencyType
    associatedtype CoordinatorType

    var viewModel: DependencyType! { get set }
    var coordinator: CoordinatorType! { get set }

    func assertDependencies()
}

extension ViewModelInjectable {

    func assertDependencies() {
        assert(viewModel != nil)
        assert(coordinator != nil)
    }
}
