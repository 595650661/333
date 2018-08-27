//
//  ViewController.swift
//  DrawVC
//
//  Created by 程云飞 on 2018/8/15.
//  Copyright © 2018年 程云飞. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pushBtn: UIButton!
    let transDelegate = SDEModalTransitionDelegate()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func btnClick(_ sender: UIButton) {
        
        let vc = LeftVC()
        vc.transitioningDelegate = transDelegate
        vc.modalPresentationStyle = .custom

        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func pushClick(_ sender: UIButton) {
        
        let secVC = SecondVC()
        
        self.navigationController?.pushViewController(secVC, animated: true)
    }
    
    
}

