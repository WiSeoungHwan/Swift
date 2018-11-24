//
//  WeatherInfoView.swift
//  Dandi1.1
//
//  Created by Wi on 24/11/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit
import SnapKit

class WeatherInfoView: UIView {
    let precipitation = UILabel() // raniyPersent
    let windSpeed = UILabel()
    let fineDustConcentration = UILabel()
    let iconsImageNames = ["precipitation", "windSpeed","findDust"]
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        createWeatherInfoView()
        
        self.backgroundColor = .lightGray
    }
    
    // MARK: 뷰만드는 걸 자동화 했습니다.
    func createWeatherInfoView(){
        let infoLabels = [precipitation, windSpeed, fineDustConcentration]
        for (i,j) in iconsImageNames.enumerated(){
            let imageView = UIImageView(image: UIImage(named: j)?.withRenderingMode(.alwaysTemplate))
            imageView.tintColor = .white
            self.addSubview(imageView)
            imageView.snp.makeConstraints { (m) in
                m.edges.leading.equalTo((i * 10) + 30)
                m.top.equalTo(self.snp.top).offset(30)
                m.size.equalTo(50)
            }
            self.addSubview(infoLabels[i])
            infoLabels[i].textAlignment = .center
            infoLabels[i].text = "t" // just Test
            infoLabels[i].textColor = .white
            infoLabels[i].snp.makeConstraints { (m) in
                m.top.equalTo(imageView.snp.bottom).offset(20)
                m.leading.equalTo(imageView.snp.leading)
                m.trailing.equalTo(imageView.snp.trailing)
            }
            
        }
    }
    
}
