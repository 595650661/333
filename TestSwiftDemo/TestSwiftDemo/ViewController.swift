//
//  ViewController.swift
//  TestSwiftDemo
//
//  Created by 程云飞 on 2018/9/28.
//  Copyright © 2018年 程云飞. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let vc = TestVC()
        vc.view.frame = self.view.bounds
        
        self.addChild(vc)
        self.view.addSubview(vc.view)
    }
    
    func test1() {
        
        let count1 = 120
        let count2 = 1
        let count3 = 10
        let count4 = 20
        let newArray = ["\(count1)": "choiceArray","\(count2)":"choiceArray2","\(count3)":"choiceArray3","\(count4)":"choiceArray4"].sorted { (dict1, dict2) -> Bool in
            return dict1.key < dict2.key
        }
        
        print("-----:\(newArray)")
        
        
        
        var array = [[String: String]]()
        array.append(["11": "0"])
        array.append(["5": "1"])
        array.append(["20": "10"])
        array.append(["14": "10"])
        array.append(["14": "10"])
        
        print("----:\(array)")
        let tmpArray = array.sorted { (dict1, dict2) -> Bool in
            
            let key1 = dict1.keys.first!
            let key2 = dict2.keys.first!
            let Int1 = Int(key1)!
            let Int2 = Int(key2)!
            // key1.compare(key2) == ComparisonResult.orderedAscending
            return Int1 > Int2
        }
        
        print("1111111:---\(tmpArray)")
        
        
        
        
        
        let elements = ["","1","4","9"]
        var newEle = [String]()
        newEle = elements
        newEle.append("110")
        print("newEle:-----\(newEle)---old:\(elements)")
        
        var score = elements.reduce("") { (result, ele) -> String in
            return result + ele
        }
        let index = score.index(score.startIndex, offsetBy: score.count - 1)
        score.insert(".", at: index)
        
        print("000000000:-----\(score)")
    }

}

