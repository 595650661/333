//
//  YFLRUManager.swift
//  YFNetWorking
//
//  Created by 程云飞 on 2018/9/10.
//  Copyright © 2018年 程云飞. All rights reserved.
//

import UIKit

let YQLRUManagerName = "YQLRUManagerName"
var operationQueue: [[String: Any]]?

class YFLRUManager: NSObject {

    
//    static let shared = YFLRUManager.init()
    class var shared: YFLRUManager {
        struct Static {
            static let instance = YFLRUManager.init()
        }
        
        if let queues = UserDefaults.standard.object(forKey: YQLRUManagerName) {
            operationQueue = NSMutableArray.init(array: queues as! NSArray) as! [[String : Any]]
        }else {
            operationQueue = []
        }
        return Static.instance
    }
    
    
    func refreshIndexOfFileNode(filename: String) {
        
        
    }
    
    func addFileNode(filename: String) {
        
        let array = operationQueue!
        for (index, item) in array.reversed().enumerated() {
            if let dict = item as? [String: Any], let fileNameStr = dict["fileName"] as? String {
                if fileNameStr == filename {
                    operationQueue?.remove(at: index)
                    break
                }
            }
        }
        
        let date = Date.init()
        let newDic = ["fileName": filename, "date": date] as [String : Any]
        operationQueue?.append(newDic)
        
        
    }
}

