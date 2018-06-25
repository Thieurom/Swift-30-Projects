//
//  AppDelegate.swift
//  GoodAsOldPhones
//
//  Copyright © 2016 Code School. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = window ?? UIWindow()
        window!.backgroundColor = .white
        
        let tabBarController = UITabBarController()
        let navigationController = UINavigationController(rootViewController: ProductListViewController())
        let contactViewController = ContactViewController()
        tabBarController.viewControllers = [navigationController, contactViewController]
        tabBarController.selectedIndex = 0
        
        window!.rootViewController = tabBarController
        window!.makeKeyAndVisible()
        
        return true
    }
}

