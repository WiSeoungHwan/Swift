//
//  ViewController.swift
//  Dandi
//
//  Created by Wi on 16/11/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController{
    @IBOutlet weak var weatherView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var weatherViewCloudImage: UIImageView!
    @IBOutlet weak var windy: UIImageView!
    @IBOutlet weak var dust: UIImageView!
    @IBOutlet weak var gpsMark: UIImageView!
    @IBOutlet weak var clothView: UIView!
    @IBOutlet weak var clothImageView: UIImageView!
    @IBOutlet weak var hourlyWeather: UIView!
    @IBOutlet weak var weeklyWeather: UIView!
    
    // Use Data Label
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var rainyPersent: UILabel!
    @IBOutlet weak var windySpeed: UILabel!
    @IBOutlet weak var dustLevel: UILabel!
    @IBOutlet weak var temp: UILabel!
    
    @IBOutlet weak var dayLabel: UILabel!
    let forecastAPIKey = "451a9d1c66f9daa0c4c1e9da1fff4ec8"
    //======= location test =========
    
    var lat = 38.2070148
    var lon = 128.59184890000006
    
    let locationManager = CLLocationManager()
    let backgroundImages = ["rainy1","rainy","cloud","smog1","sunny1"]
    let clothes = ["cloth1", "cloth2", "cloth3", "cloth4"]
    //=================================
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: randomString(array: backgroundImages))
        clothImageView.image = UIImage(named: randomString(array: clothes))
        getLocation()
        uIConfigure()
        rendering()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        backgroundAnimate()
    }
    
    func randomString(array: [String]) -> String{
        return array[Int.random(in: 0...array.count - 1)]
    }
    func rendering() {
        
        windy.image = UIImage(named: "windy")?.withRenderingMode(.alwaysTemplate)
        windy.tintColor = .white

        dust.image = UIImage(named: "dust")?.withRenderingMode(.alwaysTemplate)
        dust.tintColor = .white
        
        weatherViewCloudImage.image = UIImage(named: "water")?.withRenderingMode(.alwaysTemplate)
        weatherViewCloudImage.tintColor = .white
        
        gpsMark.image = UIImage(named: "gps")?.withRenderingMode(.alwaysTemplate)
        gpsMark.tintColor = .white
}
    func uIConfigure(){
        weatherView.layer.cornerRadius = 30
        clothView.layer.cornerRadius = 30
        hourlyWeather.layer.cornerRadius = 30
        weeklyWeather.layer.cornerRadius = 30
        clothImageView.layer.cornerRadius = 30
        clothImageView.layer.masksToBounds = true
        
        
    }

//================================================================================================================
    var dong = ""
    
    func locationCheck(){
        let location = CLLocation(latitude: lat, longitude: lon)
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placeMark, error in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            guard let address = placeMark?.first else {return}
            let country = address.country ?? ""
            let administrativeArea = address.administrativeArea ?? ""
            let locality = address.locality ?? ""
            let name = address.name ?? ""
            self.dong = name
            self.locationName.text = self.dong
            print(country, administrativeArea, locality, name)
            print(name)
        }
    }
    
    func checkFineDust() {
        let city = "서울특별시"
        let gu = "강남구"
        
        let a = "https://search.naver.com/search.naver?sm=top_hty&fbm=1&ie=utf8&query=\(city)+\(gu)+\(dong)+미세먼지"
        let b = "todaytemp"
        
        let queryEncodedStr = a.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let url = URL(string: queryEncodedStr)!
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil,
                let data = data,
                let document = String(data: data, encoding: .utf8) else { return }
            
            func isStringAnInt(string: String) -> Bool {
                return Int(string) != nil
            }
            
            var strings: [String] = []
            var ints: [String] = []
            
            for i in 10...200 {
                let word = "main_figure\">"
                let wordIncludedDust = word + String(i)
                
                if document.contains(wordIncludedDust) {
                    
                    let e = wordIncludedDust.enumerated()
                    
                    for (_, k) in e {
                        strings.append(String(k))
                    }
                    
                    for i in strings {
                        if isStringAnInt(string: i) {
                            ints.append(i)
                        }
                    }
                    
                    var b = ""
                    for i in 0..<ints.count {
                        b += ints[i]
                    }
                    DispatchQueue.main.async {
                        self.dustLevel.text = b
                    }
                    
                    print ("dust degree is :", b, "ug/cm2")
                    
                }
            }
        }
        dataTask.resume()
        
    }
//================================================================================================================
    
    func getLocation(){
        locationManager.delegate = self
        //======= location test ========='
        
        
        locationManager.requestWhenInUseAuthorization()
        
        if(CLLocationManager.locationServicesEnabled()){
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        
        //=================================
        
    }
    func backgroundAnimate(){
        UIView.animate(withDuration: 4, animations: {
            self.imageView.center.x += 70
        }) { (isComplete) in
            if isComplete {
                UIView.animate(withDuration: 4, animations: {
                    self.imageView.center.x -= 70
                }, completion: { (isComplete) in
                    if isComplete {
                        self.backgroundAnimate()
                    }
                })
            }
        }
    }
    func CelToFah(_ fah: Double) -> Int{
        let result = (fah - 32) * 5 / 9
        return Int(result)
    }
}
extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        lat = location.coordinate.latitude
        lon = location.coordinate.longitude
        
        locationCheck()
        checkFineDust()
        
        let forecastService = ForecastService(APIKey: forecastAPIKey)
        forecastService.getForecast(latitude: self.lat, longitude: self.lon)
        { (currentWeather) in
            print(self.lat, self.lon)
            // off the main queue!!
            if let currentWeather = currentWeather {
                // rule: all ui code must happen on the main queue
                // todo: get back to the main queue
                DispatchQueue.main.async {
                    if let temperature = currentWeather.temperature {
                        self.temp.text = "\(self.CelToFah(temperature))°"
                    } else {
                        self.temp.text = "-"
                    }
                    if let precipProbability = currentWeather.precipProbability{
                        self.rainyPersent.text = "\(precipProbability)%"
                    }
                    if let windySpeed = currentWeather.windSpeed{
                        self.windySpeed.text = String(format: "%.1f", windySpeed)
                    }
                    if let summary = currentWeather.summary {
                        print("summary:\(summary)")
                    }
                    
//                    let date = Date()
//                    let dateFormatter = DateFormatter()
//                    dateFormatter.dateFormat = "EEEE"
//                    var day = dateFormatter.string(from: date)
//                    self.dayLabel.text = day
                    
                    
                }
            }
            
        }
        
        
        self.locationManager.stopUpdatingLocation()
        print("location" , lat, lon)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
extension ViewController: UIScrollViewDelegate{
    
}

