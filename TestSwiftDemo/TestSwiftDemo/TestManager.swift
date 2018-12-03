//
//  TestManager.swift
//  TestSwiftDemo
//
//  Created by 程云飞 on 2018/11/23.
//  Copyright © 2018年 程云飞. All rights reserved.
//

import UIKit

class TestManager: NSObject {

    /// 单例
    private static var _shared: TestManager?
    class func shared() -> TestManager {
        guard let instance = _shared else {
            
            _shared = TestManager()
            return _shared!
        }
        return instance
    }
    /// 销毁单例
    class func destory() {
        _shared = nil
    }

    deinit {
        print("---\(self)")
    }
    /// 私有化init方法  防止其他对象通过默认构造函数直接创建这个类对象，确保你的单例是真正的独一无二
    override init() {
        super.init()
    }
}
