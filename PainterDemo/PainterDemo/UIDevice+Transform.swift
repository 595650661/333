//
//  UIDevice+Transform.swift
//  EKWScanSheet
//
//  Created by 程云飞 on 2018/8/28.
//  Copyright © 2018年 ekwing. All rights reserved.
//

import Foundation
import UIKit


extension UIDevice {
    
    ///输入要强制转屏的方向
    class func switchNewOrientation(_ orientation: UIInterfaceOrientation) {
        
        let resetOrientationTarget = NSNumber.init(value: Int8(UIInterfaceOrientation.unknown.rawValue))
        
        UIDevice.current.setValue(resetOrientationTarget, forKey: "orientation")
        
        let orientationTarget = NSNumber.init(value: Int8(orientation.rawValue))
        
        UIDevice.current.setValue(orientationTarget, forKey: "orientation")
    }
}
