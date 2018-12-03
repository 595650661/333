//
//  YFMemoryCache.swift
//  YFNetWorking
//
//  Created by 程云飞 on 2018/9/10.
//  Copyright © 2018年 程云飞. All rights reserved.
//

import UIKit

class YFMemoryCache: NSObject {

    static let shared = YFMemoryCache.init()
    
    class func readDataWithKey(key: String) -> Any? {
        
        var data: Any? = nil
        
        let cache = YFMemoryCache.shared
        data = cache.value(forKey: key)
        
        return data
    }
}
