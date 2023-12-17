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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let data = [("https://storage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg",
                         "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"),
                        ("https://storage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg",
                         "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"),
                        ("https://storage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg",
                         "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4"),
                        ("https://storage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerEscapes.jpg",
                         "http://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4"),
                        ("https://storage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerFun.jpg",
                         "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4"),
                        ("https://storage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerJoyrides.jpg",
                         "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4")]
            
            viewController.setData(data: data)
        }
        return true
    }
}

