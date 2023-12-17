//
//  AppDelegate.swift
//  videoUI2
//
//  Created by 1630880 on 12/15/2023.
//  Copyright (c) 2023 1630880. All rights reserved.
//

import UIKit
import videoUI2

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
            
        let viewController = videoUI2.VideoDisplayViewController() 
        window?.rootViewController = viewController
            
        window?.makeKeyAndVisible()
        
        return true
    }
}

