//
//  LoginTabBarController.swift
//  InstargramProject
//
//  Created by Wi on 05/11/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit

class LoginTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let login = LoginViewController()
        login.tabBarItem.title = "계정이 없으신가요?"
        self.viewControllers = [login]
    }
    

}
