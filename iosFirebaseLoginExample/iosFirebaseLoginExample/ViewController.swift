//
//  ViewController.swift
//  iosFirebaseLoginExample
//
//  Created by Wi on 14/10/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UITableViewController, GIDSignInUIDelegate  {

    @IBAction func signIn(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }


}

