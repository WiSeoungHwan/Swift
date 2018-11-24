//
//  AppDelegate.swift
//  Dandi1.1
//
//  Created by Wi on 24/11/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainViewController()
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        return true
    }


}

