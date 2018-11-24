//
//  CollectionViewController.swift
//  CollectionView
//
//  Created by Wi on 16/11/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit
import expanding_collection

class CollectionViewController: ExpandingViewController {

    override func viewDidLoad() {
        itemSize = CGSize(width: 214, height: 460) //IMPORTANT!!! Height of open state cell
        super.viewDidLoad()
        
        // register cell
        let nib = UINib(nibName: "FrontViewCell.xib", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: "frontCell")
        
    }
    
}
