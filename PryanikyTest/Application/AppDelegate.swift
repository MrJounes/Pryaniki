//
//  AppDelegate.swift
//  PryanikyTest
//
//  Created by Игорь Дикань on 04.03.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupRootViewController()
        return true
    }
}

// MARK: - Private methods
private extension AppDelegate {
    
    func setupRootViewController() {
        guard let vc = R.storyboard.main.mainViewController() else {
            return
        }
        let navigation = UINavigationController(rootViewController: vc)
        navigation.isNavigationBarHidden = true
        navigation.navigationBar.tintColor = .black
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigation
        window.makeKeyAndVisible()
        self.window = window
    }
}

