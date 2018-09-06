//
//  DrawPath.swift
//  PainterDemo
//
//  Created by 程云飞 on 2018/8/22.
//  Copyright © 2018年 程云飞. All rights reserved.
//

import UIKit

class DrawPath: UIBezierPath {

    ///路径color
    var pathColor: UIColor = UIColor.red
    ///路径宽度
    var pathWidth: CGFloat = 10
    
    override init() {
        super.init()
        
        self.lineWidth = pathWidth
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
