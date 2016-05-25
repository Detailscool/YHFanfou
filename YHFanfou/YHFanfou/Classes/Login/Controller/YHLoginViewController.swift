//
//  YHLoginViewController.swift
//  YHFanfou
//
//  Created by 陈波文 on 16/5/25.
//  Copyright © 2016年 Detailscool. All rights reserved.
//

import UIKit
import SnapKit

class YHLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupUI() {
        
        view.backgroundColor = UIColor.whiteColor()
        
        view.addSubview(nameTextfield)
        view.addSubview(passwordTextfield)
        view.addSubview(sureButton)
        
        nameTextfield.translatesAutoresizingMaskIntoConstraints = false
        passwordTextfield.translatesAutoresizingMaskIntoConstraints = false
        sureButton.translatesAutoresizingMaskIntoConstraints = false
        
        nameTextfield.snp_makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(-100)
            make.width.equalTo(200)
        }
        
        passwordTextfield.snp_makeConstraints { (make) in
            make.centerX.equalTo(nameTextfield)
            make.centerY.equalTo(nameTextfield).offset(50)
            make.width.equalTo(nameTextfield)
        }
        
        sureButton.snp_makeConstraints { (make) in
            make.centerX.equalTo(passwordTextfield)
            make.centerY.equalTo(passwordTextfield).offset(50)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        
    }
    
    //MARK: - Private
    func sureClick() {
        
    }
    
    private lazy var nameTextfield : UITextField = {
        let nt = UITextField()
        nt.backgroundColor = UIColor.redColor()
        nt.leftView = UIView(frame: CGRect(x: 0, y: 20, width: 20, height: 1))
        nt.borderStyle = UITextBorderStyle.RoundedRect
        return nt
    }()
    
    private lazy var passwordTextfield : UITextField = {
        let pt = UITextField()
        pt.borderStyle = UITextBorderStyle.RoundedRect
        return pt
    }()
    
    private lazy var sureButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("确定", forState: UIControlState.Normal)
        btn.backgroundColor = UIColor.grayColor()
        btn.addTarget(self, action: #selector(YHLoginViewController.sureClick), forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
    
    
}
