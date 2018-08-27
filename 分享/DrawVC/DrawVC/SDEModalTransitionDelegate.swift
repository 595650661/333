//
//  SDEModalTransitionDelegate.swift
//  DrawVC
//
//  Created by 程云飞 on 2018/8/15.
//  Copyright © 2018年 程云飞. All rights reserved.
//

import UIKit

class SDEModalTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return CWLateralSlideAnimator()
    }
}
