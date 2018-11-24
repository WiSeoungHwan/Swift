//
//  ViewController.swift
//  Dandi1.1
//
//  Created by Wi on 24/11/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    let backgroundView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "rainy"))
        imageView.contentMode = .scaleAspectFill
        imageView.center.x = 50
        return imageView
    }()
    let weatherInfoView = WeatherInfoView()
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        autoLayout()
        
    }
    
    func configure(){
        
        // MARK: BackgroundImageView
        
    
        UIView.animateKeyframes(withDuration: 5, delay: 0, options: [.autoreverse, .repeat], animations: {
            self.backgroundView.center.x = -50
        })
        
        
        
    }
    
    func autoLayout(){
        // MARK: addSubView
        view.addSubview(backgroundView)
        view.addSubview(weatherInfoView)
        
        // MARK: SnapKit
        backgroundView.snp.makeConstraints { (m) in
            m.edges.equalToSuperview()
        }
        weatherInfoView.snp.makeConstraints { (m) in
            m.leading.equalTo(view.snp.leading).inset(30)
            m.top.equalTo(view.snp.top).inset(400)
            m.size.equalTo(view.snp.size).dividedBy(2)
        }
    }
    
    

}

