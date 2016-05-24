//
//  YHNavigationController.swift
//  YHFanfou
//
//  Created by Detailscool on 16/5/23.
//  Copyright © 2016年 Detailscool. All rights reserved.
//

import UIKit

class YHNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
    }


}
