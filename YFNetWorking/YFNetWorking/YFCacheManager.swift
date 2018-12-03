//
//  YFCacheManager.swift
//  YFNetWorking
//
//  Created by 程云飞 on 2018/9/10.
//  Copyright © 2018年 程云飞. All rights reserved.
//

import UIKit

let cacheDirKey = "cacheDirKey"
class YFCacheManager: NSObject {

    let shared = YFCacheManager.init()
    
    
    func getCacheResponseObjectWithRequestUrl(url: String, params: [String: Any]?) -> Any? {
        
        var cacheData: Any? = nil
        
        let originString = url + "\(params)"
        let hash = originString  //需要MD5
        
        cacheData = YFMemoryCache.readDataWithKey(key: hash)
        if cacheData != nil {
            
            let directoryPath = UserDefaults.standard.object(forKey: cacheDirKey)
            if directoryPath != nil {
                
                cacheData = YFDiskCache.readDataFromDir(directory: directoryPath as! NSString, filename: hash)
                if cacheData != nil {
                    
                }
            }
        }
        
        return cacheData
    }
}
