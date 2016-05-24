//
//  YHNetworkManager.swift
//  YHFanfou
//
//  Created by Detailscool on 16/5/24.
//  Copyright © 2016年 Detailscool. All rights reserved.
//

import UIKit

class YHNetworkManager: NSObject {
    
    private static let manager : YHNetworkManager = YHNetworkManager()
    
    class func sharedManager() -> YHNetworkManager {
        return manager
    }
    
    func request(url:String,params:[String:AnyObject],finished:((AnyObject?,error:NSError?) -> Void)) {
        
        YHNetworkTool.sharedNetworkTool().GET(url, parameters: params, progress: nil, success: { (_, response) -> Void in
            
                finished(response,error: nil)
            
            }) { (_, error) -> Void in
                
                finished(nil,error: error)
        }
    }
    
}
