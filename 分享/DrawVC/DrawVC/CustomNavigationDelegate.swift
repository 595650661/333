//
//  CustomNavigationDelegate.swift
//  DrawVC
//
//  Created by 程云飞 on 2018/8/16.
//  Copyright © 2018年 程云飞. All rights reserved.
//

import UIKit

class CustomNavigationDelegate: NSObject, UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push {
            return CusNavTransAnimator.init(type: operation)
        }
        return nil
    }
    
    
}
