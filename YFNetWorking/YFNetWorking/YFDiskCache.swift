//
//  YFDiskCache.swift
//  YFNetWorking
//
//  Created by 程云飞 on 2018/9/10.
//  Copyright © 2018年 程云飞. All rights reserved.
//

import UIKit

class YFDiskCache: NSObject {

    class func readDataFromDir(directory: NSString, filename: String) -> Any? {
        
        var data: Data? = nil
        
        let filePath = directory.appendingPathComponent(filename)
        data = FileManager.default.contents(atPath: filePath)
        
        return data
    }
}
