//
//  AppDelegate.swift
//  Todo
//
//  Copyright © 2016 YiGu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = window ?? UIWindow()
        window!.backgroundColor = .white
        
        let viewController = ViewController()
        viewController.todoStore = ToDoStore()
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
        
        return true
    }
}

