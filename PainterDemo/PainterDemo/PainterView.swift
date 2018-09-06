//
//  PainterView.swift
//  PainterDemo
//
//  Created by 程云飞 on 2018/8/21.
//  Copyright © 2018年 程云飞. All rights reserved.
//

import UIKit

class PainterView: UIView {

    //外部传过来的图片
    var drawImage: UIImage!
    
    
    var layerArray: [CAShapeLayer] = []
    var recoverArr: [CAShapeLayer] = []
    var tmpLayer: CAShapeLayer!
    var tmpPath: UIBezierPath!
    
    override func draw(_ rect: CGRect) {

        let catImage = UIImage.init(named: "cat.jpg")
        catImage?.draw(in: rect)
    }

    //代码创建
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    //xib创建
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
//        setupUI()
//        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
//        let panG = UIPanGestureRecognizer.init(target: self, action: #selector(panAction(_:)))
        self.addGestureRecognizer(panG)
        
        let pinchG = UIPinchGestureRecognizer.init(target: self, action: #selector(pinchAction(_:)))
        self.addGestureRecognizer(pinchG)
    }
    
    lazy var panG: UIPanGestureRecognizer = {
        
        let panG = UIPanGestureRecognizer.init(target: self, action: #selector(panAction(_:)))
        panG.minimumNumberOfTouches = 1
        panG.maximumNumberOfTouches = 1
        
        return panG
    }()
    
    @objc func pinchAction(_ sender: UIPinchGestureRecognizer) {
        
        let view = sender.view!

        //通过捏合手势的到缩放比率
        let scale = sender.scale
        
        let transf = view.transform
        //是在视图最初的transform状态上改变，不管执行多少次，都是以该视图最初的transform状态为基础来改变
        view.transform = transf.scaledBy(x: scale, y: scale)
        //每次捏合动作完毕之后，让此捏合值复原，使得它每次都是从100%开始缩放
        sender.scale = 1.0
    }
    
    
    @objc func panAction(_ sender: UIPanGestureRecognizer) {
        
        let curP = sender.location(in: self)
        if !self.layer.contains(curP) {
            print("超出边界！！！")
            return
        }
        
        if sender.state == .began {
        
            let path = DrawPath.init()
            path.move(to: curP)
        
            
            let sLayer = CAShapeLayer.init()
            sLayer.lineCap = kCALineCapRound  //指定线的边缘是圆的
            sLayer.fillColor = UIColor.clear.cgColor
            sLayer.strokeColor = path.pathColor.cgColor
            
            tmpPath = path
            tmpLayer = sLayer
            layerArray.append(sLayer)
        }
        
        tmpPath.addLine(to: curP)
        tmpLayer.path = tmpPath.cgPath
        self.layer.addSublayer(tmpLayer)
    }
    
    func deletePath() {
        
        if layerArray.count != 0 {
            
            let layer = layerArray.last!
            recoverArr.append(layer)
            
            layer.removeFromSuperlayer()
            layerArray.removeLast()
        }
    }
    
    func recoverPath() {
        
        if recoverArr.count != 0 {
            
            let layer = recoverArr.last!
            layerArray.append(layer)
            
            self.layer.addSublayer(layer)
            recoverArr.removeLast()
        }
    }
    
    func deleteAllPath() {
        
        layerArray.map { (layer: CAShapeLayer) -> Void in
            layer.removeFromSuperlayer()
        }
        
        recoverArr.map { (layer: CAShapeLayer) -> Void in
            layer.removeFromSuperlayer()
        }
        
        layerArray.removeAll()
        recoverArr.removeAll()
    }
    
}
