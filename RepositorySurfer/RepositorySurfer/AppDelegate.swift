//
//  AppDelegate.swift
//  RepositorySurfer
//
//  Created by Jeongsik Lee on 2020/02/26.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let mainVC = Builder.buildUsersScene()
        let navVC = UINavigationController.init(rootViewController: mainVC)
        if #available(iOS 13.0, *) {
            navVC.navigationBar.backgroundColor = .systemBackground
        } else {
            navVC.navigationBar.backgroundColor = .white
        }
        navVC.navigationBar.tintColor = .systemYellow
        self.window?.rootViewController = navVC
        self.window?.makeKeyAndVisible()
        return true
    }
}
