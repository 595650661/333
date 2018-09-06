//
//  ViewController.swift
//  PainterDemo
//
//  Created by 程云飞 on 2018/8/21.
//  Copyright © 2018年 程云飞. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

    }

    

    @IBAction func pushBtnClick(_ sender: UIButton) {
        
        self.navigationController?.pushViewController(PaintVC(), animated: true)
    }
}

