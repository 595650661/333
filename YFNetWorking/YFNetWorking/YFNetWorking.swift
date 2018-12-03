//
//  YFNetWorking.swift
//  YFNetWorking
//
//  Created by 程云飞 on 2018/8/29.
//  Copyright © 2018年 程云飞. All rights reserved.
//

import UIKit
import Alamofire

typealias YFUrlSessionTask = URLSessionDataTask

typealias YFDownloadProgress = ((__int64_t, __int64_t) -> ())

typealias YFResponseSuccessBlock = ((AnyObject) -> ())

typealias YFResponseFailBlock = ((NSError) -> ())

let YF_ERROR =  NSError.init(domain: "com.hyq.YFNetworking.ErrorDomain", code: -999, userInfo: [NSLocalizedDescriptionKey: "网络出现错误，请检查网络连接"])

class YFNetWorking: NSObject {

    /// 公有的sessionManager变量
    static let sharedSessionManager: Alamofire.SessionManager = {

        //Alamofire默认的超时时间是一分钟  https://www.jianshu.com/p/c61f12788d83
        //sessionManager在退出方法后便被回收，设置自然不起作用，正确的方法是要保持一个公有的sessionManager变量，这样就不会被回收
        //https://stackoverflow.com/questions/38206150/alamofire-ignores-timeoutintervalforrequest-and-timeoutintervalforresource-param
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    func getWithUrl(_ url: String,
                    refreshRequest: Bool,
                    cache: Bool,
                    params: [String: Any]?,
                    progressBlock: YFDownloadProgress?,
                    successBlock: YFResponseSuccessBlock?,
                    failBlock: YFResponseFailBlock?) -> Void {
        
        if NetworkReachabilityManager.init()?.isReachable == false {
            if failBlock != nil {
                failBlock!(YF_ERROR)
            }
        }
    }
}
