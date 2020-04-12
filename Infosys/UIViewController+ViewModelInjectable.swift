//
//  UIViewController+ViewModelInjectable.swift
//  Infosys
//
//  Created by Saurav Mishra on 11/4/20.
//  Copyright © 2020 Saurav Mishra. All rights reserved.
//

import UIKit

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
