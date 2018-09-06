//
//  PaintVC.swift
//  PainterDemo
//
//  Created by 程云飞 on 2018/8/31.
//  Copyright © 2018年 程云飞. All rights reserved.
//

import UIKit

class PaintVC: UIViewController {
    
    func screenW() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    func screenH() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.white
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.allowRotation = true
        
        
        self.view.addSubview(bgScrollView)
        bgScrollView.addSubview(paiView)
//        self.view.addSubview(paiView)
        
        UIDevice.switchNewOrientation(.landscapeRight)
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.setStatusBarHidden(false, with: .none)
        UIApplication.shared.setStatusBarStyle(.default, animated: animated)
        
        paiView.center = self.view.center
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let viewW = self.view.bounds.size.width
        let viewH = self.view.bounds.size.height
        
        let painImage = UIImage.init(named: "cat.jpg")!
        let painImageH = painImage.size.height
        let painImageW = painImage.size.width
        
        let bgScrollViewH = viewH > painImageH ? viewH : painImageH
        
        bgScrollView.frame = self.view.bounds
        bgScrollView.contentSize = CGSize.init(width: viewW, height: bgScrollViewH)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.allowRotation = false
        UIDevice.switchNewOrientation(.portrait)
    }
    
    lazy var paiView: PainterView = {
        
        let painImage = UIImage.init(named: "cat.jpg")!
        let painImageH = painImage.size.height
        let painImageW = painImage.size.width
        return PainterView.init(frame: CGRect.init(x: 0, y: 0, width: painImageW, height: painImageH))
    }()
    
    lazy var bgScrollView: UIScrollView = {
        
        let scrol = UIScrollView.init()
        return scrol
    }()
    
    
    @IBAction func clearBtnClick(_ sender: UIButton) {
        
        let paintView = self.view as! PainterView
        paintView.deleteAllPath()
    }
    
    @IBAction func recoverBtnClick(_ sender: UIButton) {
        
        let paintView = self.view as! PainterView
        paintView.recoverPath()
    }
    
    @IBAction func deleteBtnClick(_ sender: UIButton) {
        
        let paintView = self.view as! PainterView
        paintView.deletePath()
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }
    
}
