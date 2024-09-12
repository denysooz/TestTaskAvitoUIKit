//
//  AppDelegate.swift
//  TestTaskAvitoUIKit
//
//  Created by Denis Dareuskiy on 9.09.24.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        let searchVC = SearchViewController()
        let navigationController = UINavigationController(rootViewController: searchVC)
        navigationController.navigationBar.prefersLargeTitles = true

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
}

