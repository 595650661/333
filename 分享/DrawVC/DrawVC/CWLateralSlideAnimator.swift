//
//  CWLateralSlideAnimator.swift
//  DrawVC
//
//  Created by 程云飞 on 2018/8/15.
//  Copyright © 2018年 程云飞. All rights reserved.
//

import UIKit

class CWLateralSlideAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        guard let _ = transitionContext.viewController(forKey: .from), let toVC = transitionContext.viewController(forKey: .to) else{
            return
        }
        
        let toView = toVC.view
        let toViewfinalFrame = transitionContext.finalFrame(for: toVC)
        let duration = transitionDuration(using: transitionContext)
        
        let screenBounds = UIScreen.main.bounds
        let screenW = screenBounds.size.width
        let screenH = screenBounds.size.height
        toView?.frame = CGRect.init(x: -screenW, y: 0, width: screenW, height: screenH)
        containerView.addSubview(toView!)
    
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            
            toView?.frame = toViewfinalFrame
        }, completion: {_ in
            let WasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!WasCancelled)
        })
    }
}
