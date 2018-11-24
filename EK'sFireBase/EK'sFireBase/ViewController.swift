//
//  ViewController.swift
//  EK'sFireBase
//
//  Created by Wi on 07/11/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBAction func buttonAdd(_ sender: UIButton) {
        appData()
    }
    
    func appData(){
        let key = refNames.childByAutoId().key
        let names = ["id":key, "Name": textField.text! as String]
        
        refNames.child(key!).setValue(names)
    }
    
    var ref: DatabaseReference!
    var refNames: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = Database.database().reference()
        refNames = Database.database().reference().child("Names")
        
    }


}

