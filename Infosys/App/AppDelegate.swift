//
//  AppDelegate.swift
//  Infosys
//
//  Created by Saurav Mishra on 11/4/20.
//  Copyright © 2020 Saurav Mishra. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var coordinator: AppCoordinator?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if application.applicationState != .background {
            let window = UIWindow(frame: UIScreen.main.bounds)
            let coordinator = AppCoordinator(window: window)
            coordinator.start()
            self.coordinator = coordinator
        }
        return true
    }

}
