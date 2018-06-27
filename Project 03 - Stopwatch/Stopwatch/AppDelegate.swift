//
//  AppDelegate.swift
//  Stopwatch
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
        
        let navigationController = UINavigationController(rootViewController: ViewController())
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
        
        UINavigationBar.appearance().barTintColor = .rangoon
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
        UIApplication.shared.statusBarStyle = .lightContent
        
        return true
    }
}
