//
//  CusNavTransAnimator.swift
//  DrawVC
//
//  Created by 程云飞 on 2018/8/16.
//  Copyright © 2018年 程云飞. All rights reserved.
//

import UIKit
import pop

class CusNavTransAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    var transContext: UIViewControllerContextTransitioning!
    var transOperationType: UINavigationControllerOperation!
    init(type: UINavigationControllerOperation) {
        super.init()
        transOperationType = type
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        transContext = transitionContext
        
        guard let fromVC = transitionContext.viewController(forKey: .from) as? ViewController, let toVC = transitionContext.viewController(forKey: .to) as? SecondVC else { return }
        
        let containerView = transitionContext.containerView
        let fromView = fromVC.view!
        let toView = toVC.view!
        
        
        let fromBtn = fromVC.pushBtn!
        
        let maskStartBP = UIBezierPath.init(ovalIn: fromBtn.frame)
        
        containerView.addSubview(fromView)
        containerView.addSubview(toView)
        
        let centerPoint = CGPoint.init(x: toView.frame.size.width/2.0, y: toView.frame.size.height/2.0)
        let radius = sqrt(centerPoint.x * centerPoint.x + centerPoint.y * centerPoint.y)
        
        let maskEndBP = UIBezierPath.init(ovalIn: fromBtn.frame.insetBy(dx: -radius, dy: -radius))
        
        let maskLayer = CAShapeLayer.init()
        maskLayer.path = maskEndBP.cgPath
        toView.layer.mask = maskLayer
        
        //path cgPath路径关键字
        let basicAni = CABasicAnimation.init(keyPath: "path")
        basicAni.fromValue = maskStartBP.cgPath
        basicAni.toValue = maskEndBP.cgPath
        basicAni.duration = transitionDuration(using: transitionContext)
        basicAni.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
        basicAni.delegate = self

        maskLayer.add(basicAni, forKey: "path")
        
    }
    
    
}

extension CusNavTransAnimator: POPAnimationDelegate {
    
    func pop_animationDidStop(_ anim: POPAnimation!, finished: Bool) {
        
        transContext.completeTransition(!transContext.transitionWasCancelled)
        
        transContext.viewController(forKey: .from)?.view.layer.mask = nil
        transContext.viewController(forKey: .to)?.view.layer.mask = nil
    }
}

extension CusNavTransAnimator: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        transContext.completeTransition(!transContext.transitionWasCancelled)
        
        transContext.viewController(forKey: .from)?.view.layer.mask = nil
        transContext.viewController(forKey: .to)?.view.layer.mask = nil
    }
}
