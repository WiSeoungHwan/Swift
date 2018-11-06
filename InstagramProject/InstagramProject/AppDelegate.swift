//
//  AppDelegate.swift
//  InstargramProject
//
//  Created by Wi on 05/11/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = LoginTabBarController()
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
        return true
    }



}

