//
//  ViewController.swift
//  SwiftGrimPianoExample
//
//  Created by Wi on 22/02/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var currentElement = ""
    var currentWordsNum = ""
    var currentDuration = ""
    var beforeWordsNum = ""
    var imageTempoDataList = [[String:String]]()
    var durationList = [Int]()
    var bpm: Double = 60
    var timer = Timer()
    var pageNum = 1
    var pageName = "Z"
    var imageTempo = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        xmlParsing()
//        timer = Timer.scheduledTimer(timeInterval: (bpm / 60) * Double(imageTempo), target: self, selector: #selector(timeCheck), userInfo: nil, repeats: true)
        timer = Timer.scheduledTimer(withTimeInterval: (bpm / 60) * Double(imageTempo), repeats: true, block: { (_) in
            print("TimerBlock")
            self.imageView.image = UIImage(named: self.pageName)
            self.pageNum += 1
            self.pageName = "Z\(self.pageNum)"
            self.imageTempo = self.durationList[self.pageNum]
        })
        timer.timeInterval
    }
    func xmlParsing(){
        // xml 데이터 주소 받아오기
        guard let documentsDirectory =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let xmlName = ("polkim.xml")
        let xmlURL = documentsDirectory.appendingPathComponent(xmlName)
        
        guard let parser = XMLParser(contentsOf: xmlURL) else { return }
        parser.delegate = self
        // *1-4. 준비된 파서를 실행 -> 오류나면 false 반환 -> parserError 확인
        if !parser.parse() {
            print(parser.parserError!)
        }
        print("tempoData: ", durationList)
        print(durationList.count)
    }

}

extension ViewController: XMLParserDelegate{
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        //element를 만났을때
        if elementName == "words"{
            currentElement = elementName
            print("currentElement: ",currentElement)
        }
        if elementName == "duration"{
            if currentElement == elementName{
                return
            }
            currentElement = elementName
        }
        
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        //element의 데이터
        if currentElement == "words"{
            currentWordsNum = string
            print("currentWordsNum: ", currentWordsNum)
        }
        if currentElement == "duration"{
            if beforeWordsNum == currentWordsNum {
                return
            }
            currentDuration = string
            switch string {
            case "1024":
                durationList.append(4)
            case "512":
                durationList.append(2)
            case "256":
                durationList.append(1)
            default: break
                
            }
            
            print("currentDuration:" ,currentDuration)
        }
        
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        // element가 끝날때
        if elementName == "duration"{
            beforeWordsNum = currentWordsNum
        }
        currentElement = ""

    }
    
}
