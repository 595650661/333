//
//  TestVC.swift
//  TestSwiftDemo
//
//  Created by 程云飞 on 2018/11/23.
//  Copyright © 2018年 程云飞. All rights reserved.
//

import UIKit

class TestVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let manager = TestManager.shared()
    }
    
    deinit {
        TestManager.destory()
    }

    @IBAction func btnClick(_ sender: UIButton) {
        
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
