//
//  YHTabBarController.swift
//  YHFanfou
//
//  Created by Detailscool on 16/5/23.
//  Copyright © 2016年 Detailscool. All rights reserved.
//

import UIKit

class YHTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupChildViewControllers(YHHomeViewController.self, imageName: "tabbar_mainframe",title: "Main")
        setupChildViewControllers(YHMineViewController.self, imageName: "tabbar_me",title: "Me")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupChildViewControllers(cls:AnyClass,imageName:String,title:String) {
     
        let vcCls = cls as! UIViewController.Type
        let vc = vcCls.init()
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "\(imageName)"+"HL")
        vc.title = title
        let navi = UINavigationController(rootViewController: vc)
        addChildViewController(navi)
        
    }

}
